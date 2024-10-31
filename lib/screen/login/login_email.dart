import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/screen/home.dart';
import 'package:eco2/widgets/color_background_welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../widgets/my_style_buttons.dart';
import '../home_screen.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({super.key});

  @override
  _SignInEmailState createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // دالة تسجيل الدخول باستخدام البريد الإلكتروني
  Future<void> signInWithEmail() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى إدخال البريد الإلكتروني وكلمة المرور')),
      );
      return;
    }
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل تسجيل الدخول: ${e.toString()}')),
      );
    }
  }

  // بناء واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ColorBackgroundWelcome(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/logo.png"),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'الدخول باستخدام البريد الإلكتروني',
                        textAlign: TextAlign.right,
                        style: AppConstants.bodyTextStyle,
                      ),
                    ),
                    // حقل إدخال البريد الإلكتروني
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    // حقل إدخال كلمة المرور
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // زر تسجيل الدخول باستخدام البريد الإلكتروني
                    MyStyledButton(
                      color: AppConstants.Color1,
                      title: "تسجيل الدخول",
                      onPressed: signInWithEmail,
                    ),
                    SizedBox(height: 10),
                    // زر تسجيل الدخول باستخدام Google
                    MyStyledButton(
                      color: AppConstants.Color1,
                      title: "تسجيل الدخول باستخدام Google",
                      onPressed: signInWithGoogle,
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

  // دالة تسجيل الدخول باستخدام Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // إذا تم إلغاء العملية

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل تسجيل الدخول باستخدام Google: ${e.toString()}')),
      );
    }
  }

}