// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco2/screen/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  //  createInitialData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEFFAFD),
        appBarTheme: const AppBarTheme(backgroundColor: AppConstants.Color3),
        fontFamily: "Cairo",
      ),
      home: WelcomePage(),
        builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // أو TextDirection.rtl
          child: child!,
        );
      },
    );
  }

//
// // إنشاء البيانات الأولية عند تشغيل التطبيق
// void createInitialData() {
//   // إنشاء مستخدم جديد
//   createUser('user123', 'Ali', 'ali@example.com', 'securepassword', 100, true);
//
//   // إضافة عملية جمع قمامة
//   addGarbageCollection('user123', 'collection001', 'barcode123', 'https://example.com/trash.jpg', 10);
//
//   // إضافة منتج جديد
//   createProduct('prod001', 'Reusable Water Bottle', 'Eco-friendly water bottle', 50, 'https://example.com/product.jpg');
//
//   // إضافة معاملة جديدة
//   addTransaction('trans001', 'user123', 'purchase', 50);
// }
//
// // إنشاء مستخدم جديد في مجموعة `users`
// Future<void> createUser(String userId, String name, String email, String password, int points, bool isVerified) async {
//   await FirebaseFirestore.instance.collection('users').doc(userId).set({
//     'name': name,
//     'email': email,
//     'password': password,  // من المفضل تشفير كلمة المرور قبل التخزين
//     'points': points,
//     'family_members': [],  // افتراضيًا، قائمة فارغة
//     'is_verified': isVerified,
//   });
// }
//
// // إضافة عملية جمع قمامة جديدة في مجموعة `garbage_collections`
// Future<void> addGarbageCollection(String userId, String collectionId, String barcode, String imageUrl, int ecoPoints) async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('garbage_collections')
//       .doc(collectionId)
//       .set({
//     'barcode': barcode,
//     'image_url': imageUrl,
//     'timestamp': DateTime.now(),
//     'eco_points_earned': ecoPoints,
//   });
// }
//
// // إضافة منتج جديد في مجموعة `products`
// Future<void> createProduct(String productId, String name, String description, int pointsRequired, String imageUrl) async {
//   await FirebaseFirestore.instance.collection('products').doc(productId).set({
//     'name': name,
//     'description': description,
//     'points_required': pointsRequired,
//     'image_url': imageUrl,
//   });
// }
//
// // إضافة معاملة جديدة في مجموعة `transactions`
// Future<void> addTransaction(String transactionId, String userId, String type, int amount) async {
//   await FirebaseFirestore.instance.collection('transactions').doc(transactionId).set({
//     'user_id': userId,
//     'type': type,  // شراء منتج أو تحويل نقاط
//     'amount': amount,
//     'timestamp': DateTime.now(),
//   });
// }
}