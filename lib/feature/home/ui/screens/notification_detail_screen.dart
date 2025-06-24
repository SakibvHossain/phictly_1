import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final String userId;
  final String message;
  final String clubId;

  const NotificationDetailsScreen({super.key, required this.userId, required this.message, required this.clubId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User ID: $userId", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Message: $message", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Message: $clubId", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
