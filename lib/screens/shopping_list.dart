import 'package:flutter/material.dart';
import '../models/app_notification.dart'; // Import the AppNotification model

class ShoppingList {
  List<Map<String, dynamic>> cartItems =
      []; // List to hold cart items with details
  List<AppNotification> notifications = []; // List to hold notifications

  void addItem(String item, String image, double price) {
    print("Attempting to add item: $item");
    // Check if item already exists in the cart
    final existingItem = cartItems.firstWhere(
      (cartItem) => cartItem['name'] == item,
      orElse: () => {
        'name': item,
        'image': image,
        'quantity': 0,
        'price': price
      }, // Default item structure
    );

    if (existingItem['quantity'] > 0) {
      existingItem['quantity']++; // Increment quantity if item exists
      print("Incremented quantity for $item to ${existingItem['quantity']}");
    } else {
      cartItems.add({
        'name': item,
        'image': image,
        'quantity': 1,
        'price': price
      }); // Add new item
      notifications.add(AppNotification(
        title: "Item Added",
        message: "You have added '$item' to your list.",
        timestamp: DateTime.now(),
      ));
      print("Added new item: $item");
    }
  }

  void deleteItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      // Validate index
      String itemName = cartItems[index]['name'];
      cartItems.removeAt(index); // Remove item from cart
      notifications.add(AppNotification(
        title: "Item Deleted",
        message: "You have removed '$itemName' from your list.",
        timestamp: DateTime.now(),
      ));
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      // Validate index
      cartItems[index]['quantity']++; // Increase quantity
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      // Validate index
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--; // Decrease quantity
      } else {
        deleteItem(index); // Remove item if quantity is 1
      }
    }
  }

  double calculateTotal() {
    return cartItems.fold(
        0, (total, item) => total + (item['price'] * item['quantity']));
  }
}

class ShoppingListWidget extends StatelessWidget {
  final ShoppingList shoppingList;

  ShoppingListWidget({required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shoppingList.cartItems.length,
            itemBuilder: (context, index) {
              final item = shoppingList.cartItems[index];
              return Card(
                color: Colors.transparent, // Set background to transparent
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.asset(item['image'],
                      width: 50, height: 50), // Display item image
                  title: Text(
                    item['name'],
                    style: TextStyle(
                        color: Colors.white), // Change text color to white
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: \$${item['price']}',
                        style: TextStyle(
                            color: Colors
                                .white70), // Change subtitle color for visibility
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                onPressed: () {
                                  shoppingList.decreaseQuantity(index);
                                },
                              ),
                              Text(
                                '${item['quantity']}',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Change quantity text color to white
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  shoppingList.increaseQuantity(index);
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Colors.red), // Delete button
                            onPressed: () {
                              shoppingList.deleteItem(index);
                            },
                          ),
                          Text(
                            'Total: \$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors
                                    .white), // Change total text color to white
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Cost: \$${shoppingList.calculateTotal().toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Logic to add a new item
            },
            child: Text('Add Item'),
          ),
        ),
      ],
    );
  }
}
