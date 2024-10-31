import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/globals.dart' as globals;

import '../widgets/card_home.dart';

class TawtheeqPage extends StatefulWidget {
  @override
  _TawtheeqPageState createState() => _TawtheeqPageState();
}

class _TawtheeqPageState extends State<TawtheeqPage> {
  File? _firstImage;
  File? _finalImage;
  final ImagePicker _picker = ImagePicker();
  int _userPoints = 0;  // عدد النقاط

  @override
  void initState() {
    super.initState();
    _fetchUserPoints();  // جلب الرصيد عند بدء التطبيق
  }

  // دالة لجلب عدد النقاط من Firebase
  Future<void> _fetchUserPoints() async {
    final userId = globals.userId;
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (doc.exists && doc.data() != null) {
      setState(() {
        _userPoints = doc.data()!['points'] ?? 0;
      });
    }
  }

  // دالة لتحديث عدد النقاط في Firebase
  Future<void> _updateUserPoints(int pointsToAdd) async {
    final userId = globals.userId;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'points': FieldValue.increment(pointsToAdd),  // زيادة النقاط
    });

    // تحديث النقاط في واجهة المستخدم
    setState(() {
      _userPoints += pointsToAdd;
    });
  }

  // دالة لاختيار صورة من الكاميرا
  Future<void> _pickImage(bool isFirstImage) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        if (isFirstImage) {
          _firstImage = File(image.path);
        } else {
          _finalImage = File(image.path);
        }
      });
    }
  }

  // دالة لرفع صورة واحدة إلى Firebase وتحديث النقاط
  Future<void> _uploadImage(File? image) async {
    if (image == null) return;

    try {
      final userId = globals.userId;
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images/$userId/image_$timestamp.jpg');

      await storageRef.putFile(image);
      await _updateUserPoints(10);  // زيادة النقاط بمقدار 10

      _showMessage('تم رفع الصورة وزيادة النقاط بنجاح!');
    } catch (e) {
      _showMessage('حدث خطأ أثناء رفع الصورة: $e');
    }
  }

  // دالة لعرض رسالة
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('التوثيق'),
          backgroundColor: AppConstants.Color1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // العودة إلى الصفحة السابقة
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CardHome(
                //       items: [
                //         CardItem(image: 'images/1.png', name: 'المنتج 1'),
                //         CardItem(image: 'images/1.png', name: 'المنتج 2'),
                //         CardItem(image: 'images/logo1.png', name: 'المنتج 3'),
                //       ],
                //       // image: 'images/1.png', // استبدل بمسار الصورة الصحيح
                //       // name: 'اسم المنتج', // استبدل باسم المنتج المناسب
                //     ),
                //   ),
                // );
                },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // عرض الرصيد
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      color: AppConstants.Color1,
                      child: Text(
                        'رصيدك',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      '$_userPoints',  // عرض عدد النقاط
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.teal[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // زر إضافة الصورة الأولى
                ElevatedButton.icon(
                  onPressed: () => _pickImage(true),
                  icon: Icon(Icons.add_a_photo),
                  label: Text('إضافة الصورة الأولى'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppConstants.Color3,
                    backgroundColor: Colors.grey[300],
                    alignment: Alignment.centerRight,
                  ),
                ),
                SizedBox(height: 10),

                // عرض الصورة الأولى
                if (_firstImage != null)
                  Image.file(_firstImage!, height: 150),
                SizedBox(height: 20),

                // زر إضافة الصورة النهائية
                ElevatedButton.icon(
                  onPressed: () => _pickImage(false),
                  icon: Icon(Icons.add_a_photo),
                  label: Text('إضافة الصورة النهائية'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppConstants.Color3,
                    backgroundColor: Colors.grey[300],
                    alignment: Alignment.centerRight,
                  ),
                ),
                SizedBox(height: 10),

                // عرض الصورة النهائية
                if (_finalImage != null)
                  Image.file(_finalImage!, height: 150),
                SizedBox(height: 20),

                // زر رفع الصورتين
                ElevatedButton(
                  onPressed: () async {
                    await _uploadImage(_firstImage);
                    await _uploadImage(_finalImage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.Color1,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('رفع'),
                ),

                SizedBox(height: 30),

                // إجمالي الصور والنقاط
                Row(
                  children: [
                    Expanded(child: Text('إجمالي الصور:')),
                    Expanded(child: Text(_firstImage != null && _finalImage != null ? '2' : '0')),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('نقاط إيكو =')),
                    Expanded(child: Text('ريال سعودي')),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'يمكنك تبديل النقاط في المتجر',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
