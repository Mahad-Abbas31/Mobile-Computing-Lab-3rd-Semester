import 'dart:io';

void main() {
  Map<String, double> menu = {
    "Burger": 600,
    "Pizza": 1800,
    "Fries": 300,
    "Biryani": 450,
    "Sandwich": 500,
  };

  Map<String, int> order = {};

  print("========== RESTAURANT MENU ==========");

  menu.forEach((item, price) {
    print("$item - Rs. ${price.toStringAsFixed(0)}");
  });

  print("\nEnter your order.");

  while (true) {
    stdout.write("\nEnter item name (or type 'done' to finish): ");
    String item = stdin.readLineSync()!.trim();

    if (item.toLowerCase() == "done") {
      break;
    }

    String? selectedItem;

    for (String menuItem in menu.keys) {
      if (menuItem.toLowerCase() == item.toLowerCase()) {
        selectedItem = menuItem;
        break;
      }
    }

    if (selectedItem == null) {
      print("Item not found on the menu.");
      continue;
    }

    stdout.write("Enter quantity: ");
    int? quantity = int.tryParse(stdin.readLineSync()!);

    if (quantity == null || quantity <= 0) {
      print("Invalid quantity. Please enter a positive number.");
      continue;
    }

    if (order.containsKey(selectedItem)) {
      order[selectedItem] = order[selectedItem]! + quantity;
    } else {
      order[selectedItem] = quantity;
    }

    print("$quantity × $selectedItem added to your order.");
  }

  double subtotal = 0;

  order.forEach((item, quantity) {
    subtotal += menu[item]! * quantity;
  });

  double discount = 0;

  if (subtotal > 5000) {
    discount = subtotal * 0.10;
  }

  double total = subtotal - discount;

  print("\n========== ORDER RECEIPT ==========");

  if (order.isEmpty) {
    print("No items were ordered.");
  } else {
    order.forEach((item, quantity) {
      double price = menu[item]!;
      double itemTotal = price * quantity;

      print(
        "${item.padRight(12)} "
        "${quantity} × ${price.toStringAsFixed(0).padLeft(5)}"
        " = ${itemTotal.toStringAsFixed(0)}",
      );
    });

    print("-----------------------------------");
    print("Subtotal: Rs. ${subtotal.toStringAsFixed(0)}");
    print("Discount: Rs. ${discount.toStringAsFixed(0)}");
    print("Total:    Rs. ${total.toStringAsFixed(0)}");
  }

  print("===================================");
}