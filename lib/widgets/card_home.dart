import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../constants/app_constants.dart';
import 'package:eco2/globals.dart' as globals;

class CardItem {
  final String image;
  final String name;

  CardItem({required this.image, required this.name});
}

class CardHome extends StatefulWidget {
  const CardHome({super.key, required this.items});
  final List<CardItem> items;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  void _showAddToCartSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تمت الإضافة إلى السلة!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> deductPoints(double amount) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(globals.userId)
        .get();

    double currentPoints = doc['points']?.toDouble() ?? 0.0;

    if (currentPoints >= amount) {
      double newPoints = currentPoints - amount;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(globals.userId)
          .update({'points': newPoints});

      _showAddToCartSnackbar();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("الرصيد غير كافٍ!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.Color1,
        centerTitle: true,
        title: Text("العروض"),
        actions: [
          IconButton(
            onPressed: () {
              // Add navigation if needed
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: widget.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppConstants.Color1, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              item.name,
                              style: AppConstants.titleTextStyle,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              item.image,
                              width: 200,
                              height: 130,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      color: AppConstants.Color1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => deductPoints(10.0), // Deduct 10 points
                            icon: Icon(
                              Icons.add,
                              color: AppConstants.Color2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "إضافه الى السلة",
                            style: TextStyle(color: AppConstants.Color2, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}