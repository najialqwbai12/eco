import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/widgets/color_background_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../../widgets/my_style_buttons.dart';
import '../home_screen.dart';

class ConfirmCode extends StatelessWidget {
  ConfirmCode({super.key});

  final TextEditingController verificationController = TextEditingController();

  Future<void> verifyCode(String code) async {
    // تنفيذ عملية التحقق باستخدام الكود
    print('Code completed: $code');
    // Navigate to Home
  }

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
                        'ادخل رمز التحقق',
                        textAlign: TextAlign.right,
                        style: AppConstants.bodyTextStyle,
                      ),
                    ),
                    VerificationCode(
                      length: 4,
                      keyboardType: TextInputType.number,
                      underlineColor: Colors.blue,
                      onCompleted: verifyCode,
                      onEditing: (bool isEditing) {},
                    ),
                    SizedBox(height: 30),
                    MyStyledButton(
                      color: AppConstants.Color1,
                      title: "تحقق",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false); // تنفيذ عملية التحقق
                      },
                    ),
                    SizedBox(height: 100),
                    Text("اتصل بنا..", style: AppConstants.titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
