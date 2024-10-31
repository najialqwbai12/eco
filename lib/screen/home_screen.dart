import 'package:eco2/screen/settings.dart';
import 'package:eco2/screen/tawtheeq_page.dart';
import 'package:flutter/material.dart';
import 'package:eco2/constants/app_constants.dart';
import '../widgets/CardScreen.dart';
import '../widgets/card_home.dart';
import 'MapPage.dart';
import 'home.dart';
import 'mycounty.dart';
import 'offers.dart';
import 'package:eco2/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // الفهرس المحدد
  List<Widget> pages = [
    HomePage(),
    myCounty(), // التحقق إذا كان userId ليس null     // تأكد من إضافة الصفحات المناسبة
    CardScreen(),
    CardHome( items: [
      CardItem(image: 'images/12.jpg', name: 'E-waste bar code'),
      CardItem(image: 'images/13.jpg', name: 'Plastic bar code'),
      CardItem(image: 'images/14.jpg', name: 'ORG bar code'),
      CardItem(image: 'images/15.jpg', name: 'Glass bar code'),
    ],),
    SettingPage(),   // صفحة الخريطة (أو يمكن أن تكون صفحة أخرى أيضًا)
  ];

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen with #################################################3UserId: ${globals.userId}');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: pages[selectedIndex], // عرض الصفحة بناءً على الفهرس المحدد
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value; // تحديث الفهرس عند النقر على أي تبويب
            });
          },
          currentIndex: selectedIndex,
          backgroundColor: AppConstants.Color1,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 198, 201, 201),
          selectedFontSize: 14,
          unselectedFontSize: 11,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "المحفظة"),
            BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "العروض"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الاعدادات"),
          ],
        ),
      ),
    );
  }
}