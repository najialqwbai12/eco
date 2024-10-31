import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eco2/globals.dart' as globals;
import '../../widgets/color_background_welcome.dart';
import '../home.dart';
import '../home_screen.dart';
import 'EcoEarnApp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // void _loginUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     String loginInput = _loginController.text.trim();
  //     String password = _passwordController.text.trim();
  //
  //     if (loginInput.isEmpty || password.isEmpty) {
  //       _showMessage('الرجاء إدخال جميع الحقول');
  //       return;
  //     }
  //
  //     UserCredential userCredential;
  //
  //     if (_isPhoneNumber(loginInput)) {
  //       _showMessage('تسجيل الدخول باستخدام رقم الهاتف غير مدعوم هنا.');
  //     } else {
  //       userCredential = await _auth.signInWithEmailAndPassword(
  //         email: loginInput,
  //         password: password,
  //       );
  //
  //       _showMessage('تم تسجيل الدخول بنجاح!');
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     }
  //   } catch (e) {
  //     _showMessage('حدث خطأ: ${e.toString()}');
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }


// في دالة تسجيل الدخول:
  void _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _loginController.text.trim(),
        password: _passwordController.text.trim(),
      );

      globals.userId = userCredential.user!.uid; // تخزين userId

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      _showMessage('حدث خطأ: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isPhoneNumber(String input) {
    final phoneRegex = RegExp(r'^\d{10,}$');
    return phoneRegex.hasMatch(input);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ColorBackgroundWelcome(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png', height: 150),
                      const SizedBox(height: 20),
                      Text(
                        'مرحبا بعودتك',
                        style: GoogleFonts.almarai(
                          textStyle: const TextStyle(
                            fontSize: 28,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'سجل دخولك وتمتع بمزايا الخدمة',
                        style: GoogleFonts.almarai(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        hint: 'رقم الهاتف أو البريد الإلكتروني',
                        icon: Icons.person,
                        color: Colors.blue.shade800,
                        controller: _loginController,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        hint: 'كلمة المرور',
                        icon: Icons.lock,
                        color: Colors.blue.shade800,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'هل نسيت كلمة المرور؟',
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      const SizedBox(height: 30),
                      _buildButton(
                        context: context,
                        text: 'تسجيل الدخول',
                        color: Colors.blue.shade800,
                        onPressed: _isLoading ? null : _loginUser,
                      ),
                      const SizedBox(height: 10),
                      _buildButton(
                        context: context,
                        text: 'تسجيل حساب',
                        color: Colors.blue.shade800,
                        onPressed: _isLoading ? null : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      const Icon(Icons.fingerprint, size: 60, color: Colors.white),
                      const SizedBox(height: 10),
                      const Text(
                        'الإصدار: 267',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

            )
        )
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false, required Color color,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required Color color,
    required VoidCallback? onPressed,
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
