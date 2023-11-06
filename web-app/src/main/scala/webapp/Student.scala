package webapp

import play.api.libs.json._

case class Student(id: String, name: String, age: Int, classmates: List[String], leadTeacher: String)

object Student {
  implicit val format: OFormat[Student] = Json.format[Student]
}
