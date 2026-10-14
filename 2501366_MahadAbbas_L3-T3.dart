// Write a Dart program using Object-Oriented Programming concepts.
// 1. Create a base class named Laboratory with:
//    - Two data fields: name (String) and location (String).
//    - A no-argument constructor that initializes the fields with default values: "NoName" and "NULL".
//    - A member function input() to take input for the data fields.
//    - A member function show() to display the details of the laboratory.

import 'dart:io';

class Laboratory {
  String name;
  String location;

  // ___ No-argument constructor
  Laboratory()
      : name = "NoName",
        location = "NULL";

  // ___ Input function
  void input() {
    stdout.write("Enter laboratory name: ");
    name = stdin.readLineSync()!;

    stdout.write("Enter laboratory location: ");
    location = stdin.readLineSync()!;
  }

  // ___ Show function
  void show() {
    print("Laboratory Name: $name");
    print("Location: $location");
  }
}

// 2. Derive a class WetLab from Laboratory that includes:
//    - Additional data fields: no_of_microscopes (int) and scientist_name (String).
//    - Mutator (setters) and accessor (getters) for new data fields.
//    - An overriding input() function to take input for all data fields (inherited + new).
//    - An overriding show() function to display complete details of the WetLab.

class WetLab extends Laboratory {
  int _noOfMicroscopes = 0;
  String _scientistName = "NoScientist";

  // ___ Setter
  set noOfMicroscopes(int value) {
    _noOfMicroscopes = value;
  }

  // ___ Getter
  int get noOfMicroscopes {
    return _noOfMicroscopes;
  }

  // ___ Setter
  set scientistName(String value) {
    _scientistName = value;
  }

  // ___ Getter
  String get scientistName {
    return _scientistName;
  }

  // ___ Overriding input()
  @override
  void input() {
    super.input();

    stdout.write("Enter number of microscopes: ");
    noOfMicroscopes = int.parse(stdin.readLineSync()!);

    stdout.write("Enter scientist name: ");
    scientistName = stdin.readLineSync()!;
  }

  // ___ Overriding show()
  @override
  void show() {
    print("\n--- Wet Laboratory Details ---");
    print("Laboratory Name: $name");
    print("Location: $location");
    print("Number of Microscopes: $noOfMicroscopes");
    print("Scientist Name: $scientistName");
  }
}

// 3. Derive another class DryLab from Laboratory that includes:
//    - Additional data fields: no_of_computers (int) and capacity (int).
//    - Setters and getters for new fields.
//    - An overriding input() function to take input for all data fields.
//    - An overriding show() function to display complete details of the DryLab.

class DryLab extends Laboratory {
  int _noOfComputers = 0;
  int _capacity = 0;

  // ___ Setter
  set noOfComputers(int value) {
    _noOfComputers = value;
  }

  // ___ Getter
  int get noOfComputers {
    return _noOfComputers;
  }

  // ___ Setter
  set capacity(int value) {
    _capacity = value;
  }

  // ___ Getter
  int get capacity {
    return _capacity;
  }

  // ___ Overriding input()
  @override
  void input() {
    super.input();

    stdout.write("Enter number of computers: ");
    noOfComputers = int.parse(stdin.readLineSync()!);

    stdout.write("Enter capacity: ");
    capacity = int.parse(stdin.readLineSync()!);
  }

  // ___ Overriding show()
  @override
  void show() {
    print("\n--- Dry Laboratory Details ---");
    print("Laboratory Name: $name");
    print("Location: $location");
    print("Number of Computers: $noOfComputers");
    print("Capacity: $capacity");
  }
}


// 4. In the main() function:
//    - Create an instance of Laboratory, WetLab, and DryLab.
//    - Call the input() and show() functions for each instance to test the functionality of overridden member functions.
void main() {
  // ___ Laboratory object
  Laboratory lab = Laboratory();

  print("\n=== Laboratory ===");
  lab.input();
  lab.show();

  // ___ WetLab object
  WetLab wetLab = WetLab();

  print("\n=== Wet Lab ===");
  wetLab.input();
  wetLab.show();

  // ___ DryLab object
  DryLab dryLab = DryLab();

  print("\n=== Dry Lab ===");
  dryLab.input();
  dryLab.show();
}