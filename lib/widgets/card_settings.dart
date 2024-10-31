// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CardSettings extends StatelessWidget {
  CardSettings({super.key, required this.icon, required this.name });
  Icon icon;
  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 90,
          width: 1000,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 0.5, color: AppConstants.Color3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // لون الظل
                spreadRadius: 1, // مدى انتشار الظل
                blurRadius: 7, // مدى تمويه الظل
                offset: Offset(0, 1), // إزاحة الظل
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                    height: 80,
                    width: 74,
                    decoration: BoxDecoration(
                      color: AppConstants.Color1,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border:
                          Border.all(width: 1.5, color: AppConstants.Color1),
                    ),
                    child: icon),
              ),
              Text(name, style: TextStyle(fontSize: 20))
            ],
          ),
        ));
  }
}
