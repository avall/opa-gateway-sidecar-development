package webapp

import play.api.libs.json._

case class Teacher(id: String, name: String)

object Teacher {
  implicit val format: OFormat[Teacher] = Json.format[Teacher]
}
