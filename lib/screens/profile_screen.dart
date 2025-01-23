import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "John Doe"; // Example name
  final String userAddress = "123 Main St, Springfield"; // Example address
  final String profilePicturePath = "images/Latte.png"; // Local image path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profilePicturePath), // Use local image
            ),
            SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              userAddress,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality here
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}