package webapp

import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.event.slf4j.Logger
import akka.http.scaladsl.model._
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.server.Route
import akka.http.scaladsl.Http
import com.typesafe.config.{Config, ConfigFactory}
import play.api.libs.json._

import scala.concurrent.{Await, Future}
import scala.concurrent.duration.Duration

object WebServer {

  def main(args: Array[String]): Unit = {

    val LOGGER = Logger.apply(WebServer.getClass.getCanonicalName)
    val config: Config = ConfigFactory.load().getConfig("web-app")

    implicit val system = ActorSystem(Behaviors.empty, "demo")
    implicit val ec = system.executionContext

    val route: Route =
      path("teachers") {
        get {
          complete(
            HttpResponse(status = StatusCodes.OK,
                         entity = HttpEntity(ContentTypes.`application/json`, Json.stringify(Json.toJson(MockData.teachers)))
            )
          )
        }
      } ~
      path("teachers" / Segment) { teacherId =>
        get {
          MockData.teachers.find(_.id == teacherId) match {
            case Some(teacher) =>
              complete(
                HttpResponse(status = StatusCodes.OK,
                             entity = HttpEntity(ContentTypes.`application/json`, Json.stringify(Json.toJson(teacher)))
                )
              )
            case None =>
              complete(HttpResponse(status = StatusCodes.NotFound))
          }
        }
      } ~
      path("students") {
        val json = Json.toJson(MockData.students.map(Json.toJson(_).as[JsObject] - "age"))
        get {
          complete(
            HttpResponse(status = StatusCodes.OK, entity = HttpEntity(ContentTypes.`application/json`, Json.stringify(json)))
          )
        }
      } ~
      pathPrefix("students" / Segment) { studentId =>
        get {
          path("profile") {
            MockData.students.find(_.id == studentId) match {
              case Some(student) =>
                complete(
                  HttpResponse(status = StatusCodes.OK,
                               entity = HttpEntity(ContentTypes.`application/json`, Json.stringify(Json.toJson(student)))
                  )
                )
              case None =>
                complete(HttpResponse(status = StatusCodes.NotFound))
            }
          } ~
          path("public-profile") {
            MockData.students.find(_.id == studentId) match {
              case Some(student) =>
                val json = Json.toJson(student).as[JsObject]
                complete(
                  HttpResponse(status = StatusCodes.OK,
                               entity = HttpEntity(ContentTypes.`application/json`, Json.stringify(json - "age"))
                  )
                )
              case None =>
                complete(HttpResponse(status = StatusCodes.NotFound))
            }
          }
        }
      }

    val host: String = Option(config.getString("http.address")).getOrElse("0.0.0.0")
    val port: Int = Option(config.getInt("http.port")).getOrElse(9090)
    LOGGER.info("Starting service to bind at %s on port %s", host, port)
    val server: Future[Http.ServerBinding] = Http().newServerAt(host, port).bind(route)

    server.map { bound =>
      LOGGER.info(s"Demo web api app service online at http://{}:{}/",
                  bound.localAddress.getHostString,
                  bound.localAddress.getPort.toString
      )

    }
    server.failed.foreach { e =>
      system.terminate()
      LOGGER.error(s"Server could not start!", e)
    }
    Await.result(system.whenTerminated, Duration.Inf)

  }
}
