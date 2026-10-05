// void optionalNamed(String? name, {int? sem, double cgpa = 3.5}) {
//   print("Name: $name, Semester: $sem, CGPA: $cgpa");
// }

// void optionalPostion([String? name, int? sem, double cgpa = 3.5]) {
//   print("Name: $name, Semester: $sem, CGPA: $cgpa");
// }

// void main() {
//   optionalNamed("Mahad");
// }

// class Student {
//   String name;
//   int? _marks;
//   int _age;

//   Student(this.name, this._marks, this._age);

//   Student.guest() : name = "Guest", _marks = 0, _age = 18;

//   set studentName(String newName) => name = newName;

//   String get studentName => name;

//   set marks(int newMarks) => _marks = newMarks;

//   int? get marks => _marks;

//   set age(int newAge) {
//     if (newAge > 10 && newAge < 80) {
//       _age = newAge;
//     } else {
//       print("Age must be greater than 10 and less than 80.");
//     }
//   }

//   int get age => _age;

//   void display() {
//     print("Name: $name, Marks: $_marks, Age: $_age");
//   }
// }

// void main() {
//   Student st1 = Student("Unknown", 0, 20);

//   st1.display();

//   st1.studentName = "Mahad";
//   st1.marks = 100;

//   st1.age = 25; // Valid
//   st1.display();

//   st1.age = 5; // Invalid
//   st1.display();

//   st1.age = 85; // Invalid
//   st1.display();

//   print("Age: ${st1.age}"); // Getter
// }



class Student {
  String name;
  int age;

  Student(this.name, this.age);

  void displayStudent() {
    print("Name: $name");
    print("Age: $age");
  }
}

class GraduateStudent extends Student {
  String degree;

  GraduateStudent(String name, int age, this.degree)
      : super(name, age);

  void displayDegree() {
    print("Degree: $degree");
  }
}

void main() {
  GraduateStudent student =
      GraduateStudent("Mahad", 21, "BS Computer Science");

  student.displayStudent();
  student.displayDegree();
}