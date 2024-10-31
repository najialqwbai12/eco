import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/widgets/color_background_welcome.dart';
import 'package:flutter/material.dart';

import '../login/loginEcoEarnApp.dart';

class WelcomePage extends StatefulWidget { // نغير من Stateless إلى Stateful
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = true; // متغير الحالة

  @override
  void initState() {
    super.initState();
    _loadImage(); // بدء تحميل الصورة
  }

  Future<void> _loadImage() async {
    await Future.delayed(Duration(seconds: 2)); // محاكاة فترة تحميل
    setState(() {
      _isLoading = false; // تغيير الحالة بعد تحميل الصورة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorBackgroundWelcome(
        child: Center(
          child: _isLoading // تحقق من حالة التحميل
              ? CircularProgressIndicator() // عرض شاشة التحميل
              : Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset("images/logo.png"),
                SizedBox(height: 20),
                Text(
                  '"مرحباً بك... "معّا لنصون البيئة ونحمي أرضنا.',
                  textAlign: TextAlign.center,
                  style: AppConstants.titleTextStyle,
                ),
                SizedBox(height: 200),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                    );
                  },
                  child: Text(
                    'التالي',
                    textAlign: TextAlign.center,
                    style: AppConstants.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}