import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MyStyledButton extends StatelessWidget {
  const MyStyledButton(
      {super.key, required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: AppConstants.Color1, width: 2), // لون الحدود
            borderRadius: BorderRadius.circular(10), // شكل الزوايا
          ),
          child: Material(
            elevation: 5,
            color: color,
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
              onPressed: onPressed,
              minWidth: 200,
              height: 42,
              child: Text(
                title,
                style: TextStyle(
                    color: AppConstants.Color2,
                    fontSize: fontSize * 0.055,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
