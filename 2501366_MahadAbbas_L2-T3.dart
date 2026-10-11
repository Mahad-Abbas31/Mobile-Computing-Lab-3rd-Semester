
import 'dart:io';

void main() {
  List<String> bookTitles = [];
  List<int> bookCopies = [];

  print("========== PART A ==========");

  stdout.write("Enter book title: ");
  String title = stdin.readLineSync()!;

  stdout.write("Enter author name: ");
  String author = stdin.readLineSync()!;

  stdout.write("Enter number of copies: ");
  int copies = int.parse(stdin.readLineSync()!);

  print("\nBook: $title");
  print("Author: $author");
  print("Copies: $copies");

  print("\n========== PART B ==========");

  if (copies > 0) {
    print("Book is available.");
  } else {
    print("Book is unavailable.");
  }

  print("\n========== PART C ==========");

  for (int i = 0; i < 5; i++) {
    stdout.write("Enter title of book ${i + 1}: ");
    String bookTitle = stdin.readLineSync()!;

    stdout.write("Enter number of copies: ");
    int bookCopy = int.parse(stdin.readLineSync()!);

    bookTitles.add(bookTitle);
    bookCopies.add(bookCopy);
  }

  print("\nRegistered Books:");

  for (int i = 0; i < bookTitles.length; i++) {
    print("${bookTitles[i]} - ${bookCopies[i]} copies");
  }


  print("\n========== PART D ==========");
  print("Available Books:");

  for (int i = 0; i < bookTitles.length; i++) {
    if (bookCopies[i] > 0) {
      print("${bookTitles[i]} - ${bookCopies[i]} copies");
    }
  }


  print("\n========== PART E ==========");

  bool running = true;

  while (running) {
    print("\n===== LIBRARY MENU =====");
    print("1. Add Book");
    print("2. View Books");
    print("3. Check Book");
    print("4. Exit");

    stdout.write("Enter your choice: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter book title: ");
        String newTitle = stdin.readLineSync()!;

        stdout.write("Enter number of copies: ");
        int newCopies = int.parse(stdin.readLineSync()!);

        bookTitles.add(newTitle);
        bookCopies.add(newCopies);

        print("Book added successfully.");
        break;

      case 2:
        print("\n===== ALL BOOKS =====");

        if (bookTitles.isEmpty) {
          print("No books available.");
        } else {
          for (int i = 0; i < bookTitles.length; i++) {
            print(
              "${i + 1}. ${bookTitles[i]} - "
              "${bookCopies[i]} copies",
            );
          }
        }
        break;

      case 3:
        stdout.write("Enter book title to search: ");
        String searchTitle = stdin.readLineSync()!;

        bool found = false;

        bookTitles.asMap().forEach((index, bookTitle) {
          if (bookTitle.toLowerCase() == searchTitle.toLowerCase()) {
            print("Book Found: $bookTitle");
            print("Copies: ${bookCopies[index]}");
            found = true;
          }
        });

        if (!found) {
          print("Book Not Found");
        }

        break;

      case 4:
        print("Exiting library system...");
        running = false;
        break;

      default:
        print("Invalid choice. Please select 1-4.");
    }
  }

  print("\nLibrary System Closed.");
}