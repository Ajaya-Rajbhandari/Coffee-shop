import 'package:flutter/material.dart';
import '../models/app_notification.dart'; // Import the new AppNotification model

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<AppNotification> notifications = [];
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    // Reset notifications when the screen is visited
    notifications.clear();
    notificationCount = 0;
  }

  void addItem(String itemName) {
    setState(() {
      notifications.add(AppNotification(
        title: "Item Added",
        message: "You have added '$itemName' to your list.",
        timestamp: DateTime.now(),
      ));
      notificationCount++;
    });
  }

  void removeItem(String itemName) {
    setState(() {
      notifications.add(AppNotification(
        title: "Item Deleted",
        message: "You have removed '$itemName' from your list.",
        timestamp: DateTime.now(),
      ));
      notificationCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blueAccent,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Add functionality here
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                'No Notifications yet.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(
                    notification.title,
                    style: TextStyle(color: Colors.yellow), // Bright color for text
                  ),
                  subtitle: Text(
                    notification.message,
                    style: TextStyle(color: Colors.yellow), // Bright color for text
                  ),
                  trailing: Text(notification.timestamp.toLocal().toString()),
                );
              },
            ),
    );
  }
}