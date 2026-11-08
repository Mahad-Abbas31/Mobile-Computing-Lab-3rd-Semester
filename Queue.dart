import 'dart:collection';

void main() {
  Queue<String> students = Queue<String>();

  students.add("Ali");
  students.add("Ahmed");
  students.add("Mahad");

  print("Queue: $students");

  print("First student: ${students.first}");

  students.removeFirst();

  print("After removing first: $students");
}