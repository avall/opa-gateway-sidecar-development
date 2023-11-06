package webapp

object MockData {

  val amanda = Teacher(id = "t1", name = "Amanda Harper")
  val john = Teacher(id = "t2", name = "John O'Callaghan")

  lazy val amit =
    Student(id = "s1", name = "Amit Lamba", age = 19, classmates = List("s1", "s2", "s3", "s4"), leadTeacher = amanda.id)
  lazy val ann =
    Student(id = "s2", name = "Anne-Marie Slaughter", age = 21, classmates = List("s1", "s2", "s3", "s4"), leadTeacher = amanda.id)
  lazy val neo =
    Student(id = "s3", name = "Neo Anderson", age = 22, classmates = List("s1", "s2", "s3", "s4"), leadTeacher = john.id)
  lazy val phophen =
    Student(id = "s4", name = "Phophen Wong", age = 21, classmates = List("s1", "s2", "s3", "s4"), leadTeacher = john.id)

  val teachers = List(amanda, john)
  val students = List(amit, ann, neo, phophen)

}
