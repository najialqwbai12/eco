import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ColorBackgroundWelcome extends StatefulWidget {
  ColorBackgroundWelcome({super.key, required this.child});
  Widget child;
  @override
  State<ColorBackgroundWelcome> createState() => _ColorBackgroundWelcomeState();
}

class _ColorBackgroundWelcomeState extends State<ColorBackgroundWelcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00689D),
            Color(0xFF6BA9C8),
            Color(0xFFCFE7F0),
            Color(0xFFEFFAFD),
            Color(0xFFEFFAFD),
            Color(0xFFBBDBE8),
            Color(0xFF99C4D8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2), // لون الظل
        //     spreadRadius: 5, // نطاق انتشار الظل
        //     blurRadius: 7, // نسبة ضبابية الظل
        //     offset: const Offset(2, 3), // التحريك الأفقي والعمودي للظل
        //   ),
        // ],
      ),
      // باقي خصائص الـ Container

      child: widget.child,
    );
  }
}
