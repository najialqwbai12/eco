import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:eco2/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/widgets/NewHomeScreen.dart';
import 'package:eco2/widgets/my_style_buttons.dart';
import 'package:eco2/globals.dart' as globals;
import '../globals.dart';
import 'add_beneficiary.dart';
import '../widgets/my_style_textField.dart';

class myCounty extends StatefulWidget {
  const myCounty({Key? key}) : super(key: key);

  @override
  State<myCounty> createState() => _myCountyState();
}

class _myCountyState extends State<myCounty> {
  // متغيرات لتخزين البيانات
  String accountNumber = '';
  String phoneNumber = '';
  String name = '';
  String email = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // استدعاء دالة جلب البيانات
  }

  // دالة لجلب البيانات من Firestore باستخدام معرف المستخدم
  Future<void> fetchData() async {
    try {
      final userId = globals.userId; // احصل على userId من globals
      print('Fetching data for userId: $userId'); // طباعة لمعرفة userId

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        print('Data fetched successfully: ${doc.data()}'); // طباعة البيانات
        setState(() {
          accountNumber = doc['accountNumber'] ?? '';
          phoneNumber = doc['phone'] ?? '';
          name = doc['fullName'] ?? '';
          email = doc['email'] ?? '';
        });
      } else {
        _showMessage('لم يتم العثور على بيانات للمستخدم.');
      }
    } catch (e) {
      _showMessage('خطأ في جلب البيانات: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // دالة لعرض رسالة في SnackBar
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
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          backgroundColor: AppConstants.Color1,
          centerTitle: true,
          title: const Text("حسابي الشخصي"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              icon: const Icon(Icons.list),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildReadOnlyField(
                text: accountNumber,
                hint: accountNumber,//"رقم العضوية",
                icon: Icons.badge,
              ),
              const SizedBox(height: 20),
              _buildReadOnlyField(
              
                hint: phoneNumber,//"رقم الجوال",
                text: phoneNumber,
                icon: Icons.phone,
              ),
              const SizedBox(height: 20),
              _buildReadOnlyField(
                text: name,
                hint: name,//"الاسم",
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              _buildReadOnlyField(
                text: email,
                hint: email,//"البريد الإلكتروني",
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              MyStyledButton(
                color: AppConstants.Color1,
                title: "إضافة مستفيدين",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBeneficiaryPage(userId:globals.userId.toString())),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء حقل قراءة فقط
  Widget _buildReadOnlyField({
    required String text,
    required String hint,
    required IconData icon,
  }) {
    return MyStyledTextFieldSmoll(
      text: hint,
      icon: Icon(
        icon,
        size: 35,
        color: AppConstants.Color1,
      ),
      controller: TextEditingController(text: text),
      readOnly: true,
    );
  }
}