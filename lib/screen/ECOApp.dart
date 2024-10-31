import 'package:eco2/screen/tawtheeq_page.dart';
import 'package:flutter/material.dart';

import '../widgets/CardScreen.dart';
import 'home.dart';
import 'home_screen.dart';
import 'mycounty.dart';
import 'offers.dart';




class ECOApp extends StatefulWidget {
  const ECOApp({super.key});

  @override
  _ECOAppState createState() => _ECOAppState();
}

class _ECOAppState extends State<ECOApp> {
  final List<Widget> screens = [
    myCounty(),      // تأكد من إضافة الصفحات المناسبة
    CardScreen(),
    HomePage(),
    offersPage(),
    TawtheeqPage(), // Assuming you want to repeat the CardScreen for demo purposes
  ]; // Screens for each tab

  int selectedTab = 0; // Default index of first tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1), // Dark blue background
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "حسابك الشخصي",
            backgroundColor:  Color.fromRGBO(38, 81, 158, 1), // Specific background for 'Map' tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "المحقظة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map), // Icon for the fourth page
            label: "الخريطة",
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedTab = index; // Change the currently displayed tab
          });
        },
        currentIndex: selectedTab, // Ensure the selected tab is highlighted
        showUnselectedLabels: true,
        iconSize: 30,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the FAB button
        },
        elevation: 0,
        child: Icon(Icons.qr_code_2_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: IndexedStack(
        index: selectedTab,
        children: screens,
      ), // This keeps state of the pages
    );
  }
}
