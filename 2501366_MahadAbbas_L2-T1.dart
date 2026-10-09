void main() {
  String? name;
  String? department;
  int marks = 72;

  String studentName = name ?? "Guest Student";

  department ??= "General";

  String status = marks >= 50 ? "Pass" : "Fail";

  print("===== STUDENT PROFILE =====");
  print("Name: $studentName");
  print("Department: $department");
  print("Marks: $marks");
  print("Status: $status");
}

// ___ ??   We use ?? because it provides "Guest Student" when the student's name is null.
// ___ ??=  We use ??= because it assigns "General" to the department only when the department is null.
// ___ ?:   We use ?: because it selects "Pass" when marks are 50 or above and "Fail" otherwise.