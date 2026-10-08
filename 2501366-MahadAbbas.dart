class Person {
  String name;

  Person(this.name);

  void introduce() {
    print("My name is $name.");
  }
}

mixin SportsPlayer on Person {
  void playSport() {
    print("$name is playing football.");
  }
}

mixin Coder on Person {
  void writeCode() {
    print("$name is writing Dart code.");
  }
}

class Student extends Person with SportsPlayer, Coder {
  Student(String name) : super(name);
}

class Teacher extends Person with Coder {
  Teacher(String name) : super(name);
}

void main() {
  Student student = Student("Ayesha");

  student.introduce();
  student.playSport();
  student.writeCode();

  print("");

  Teacher teacher = Teacher("Ahmed");

  teacher.introduce();
  teacher.writeCode();
}