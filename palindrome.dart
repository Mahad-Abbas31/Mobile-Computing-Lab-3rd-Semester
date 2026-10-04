import 'dart:io';

void main() {
  print("Enter a string:");
  String input = stdin.readLineSync()!;

  String reversed = input.split('').reversed.join('');

  if (input == reversed) {
    print("The string is a palindrome.");
  } else {
    print("The string is not a palindrome.");
  }
}