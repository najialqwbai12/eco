import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/color_background_welcome.dart';

class AddBeneficiaryPage extends StatefulWidget {
  final String userId; // استلام userId كمُعطى
  const AddBeneficiaryPage({super.key, required this.userId});

  @override
  _AddBeneficiaryPageState createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  final _firestore = FirebaseFirestore.instance;

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // إضافة مستفيد إلى Firebase
  Future<void> _addBeneficiary() async {
    try {
      await _firestore
          .collection('users')
          .doc(widget.userId) // حفظ المستفيد ضمن المستخدم المعني
          .collection('beneficiaries')
          .add({
        'fullName': _fullNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showMessage('تم إضافة المستفيد بنجاح!');
      _clearFields();
    } catch (e) {
      _showMessage('حدث خطأ: $e');
    }
  }

  // عرض رسائل نجاح أو خطأ
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // تفريغ الحقول بعد الإضافة
  void _clearFields() {
    _fullNameController.clear();
    _phoneController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A75B9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("إضافة مستفيد"),
        centerTitle: true,
      ),
      body: ColorBackgroundWelcome(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logo.png', height: 150),
                    const SizedBox(height: 20),
                    _buildTextField('الاسم الكامل', Icons.person, _fullNameController),
                    const SizedBox(height: 10),
                    _buildTextField('رقم الهاتف', Icons.phone, _phoneController),
                    const SizedBox(height: 10),
                    _buildTextField('البريد الإلكتروني', Icons.email, _emailController),
                    const SizedBox(height: 30),
                    _buildButton(
                      context: context,
                      text: 'إضافة مستفيد',
                      color: Colors.blue.shade800,
                      onPressed: _addBeneficiary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.almarai(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
