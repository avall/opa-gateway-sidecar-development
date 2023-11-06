/** ****************************************************************************
  * SBT Settings
  * ****************************************************************************
  */
logLevel := util.Level.Info

/** ****************************************************************************
  * Packaging Settings
  * ****************************************************************************
  */
enablePlugins(JavaServerAppPackaging)

/** ****************************************************************************
  * Core Application
  * ****************************************************************************
  */
name := "web-app"
packageName := "web-app"
organization := "cloud.yantra.oss"
maintainer := sys.env.getOrElse("APP_MAINTAINER", "pratim@chaudhuri.me")

version := "0.1.0"

lazy val akkaVersion = "2.6.14"
lazy val akkaHttpVersion = "10.2.4"

lazy val `web-app` = (project in file("."))
  .settings(
    scalaVersion := "2.13.5",
    libraryDependencies ++= Seq(
      "com.typesafe.akka" %% "akka-actor-typed"         % akkaVersion,
      "com.typesafe.akka" %% "akka-stream-typed"        % akkaVersion,
      "com.typesafe.akka" %% "akka-http"                % akkaHttpVersion,
      "com.typesafe.play" %% "play-json"                % "2.9.2",
      "ch.qos.logback"     % "logback-classic"          % "1.2.3",
      "com.typesafe.akka" %% "akka-actor-testkit-typed" % akkaVersion % Test,
      "org.scalatest"     %% "scalatest"                % "3.1.0"     % Test
    ),
    licenses := List("GPLv3" -> url("https://www.gnu.org/licenses/gpl-3.0.html")),
    homepage := Some(url(sys.env.getOrElse("APP_HOMEPAGE", "https://gitlab.com/cloud.yantra.oss/opa-gateway-sidecar")))
  )
