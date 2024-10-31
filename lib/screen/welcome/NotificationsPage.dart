import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco2/globals.dart' as globals;

class NotificationsPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: globals.userId)
        .orderBy('date', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF0A75B9),
        title: Text("الإشعارات"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(" "));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد إشعارات"));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification['message']),
                subtitle: Text(notification['date'].toDate().toString()),
              );
            },
          );
        },
      ),
    );
  }
}