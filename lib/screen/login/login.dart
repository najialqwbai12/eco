import 'package:eco2/constants/app_constants.dart';
import 'package:eco2/screen/home.dart';
import 'package:eco2/widgets/color_background_welcome.dart';
import 'package:flutter/material.dart';
import '../../../widgets/my_style_buttons.dart';
import '../../widgets/my_style_textField.dart';
import 'confirm_code_page.dart';
import 'login_email.dart';

class signIn extends StatelessWidget {
  const signIn({super.key});

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
                    SizedBox(
                        width: 10000,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'الدخول باستخدام الرقم',
                            textAlign: TextAlign.right,
                            style: AppConstants.bodyTextStyle,
                          ),
                        )),
                    NumberField(),
                   SizedBox(
  width: 10000,
  child: Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 100),
    child: GestureDetector(
      onTap: () {
        // هنا ضع الكود الذي ينقل إلى صفحة home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInEmail()),
        );
      },
      child: Text(
        'الدخول باستخدام البريد الالكتروني',
        textAlign: TextAlign.right,
        style: AppConstants.bodyTextStyle,
      ),
    ),
  ),
),
                    MyStyledButton(
                        color: AppConstants.Color1,
                        title: "متابعة",
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmCode()),
                              (route) => false);
                        },
                      ) ],
                )),
              ),
            ))));
  }
}
