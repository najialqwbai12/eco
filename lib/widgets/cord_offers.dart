// ignore_for_file: must_be_immutable

import 'package:eco2/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CardOffers extends StatelessWidget {
  CardOffers(
      {super.key,
      required this.image,
      required this.title,
      required this.body});
  String image;
  String title;
  String body;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            border: Border.all(width: 1.5, color: AppConstants.Color1)),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: AppConstants.Color1)),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppConstants.titleTextStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  body,
                  style: AppConstants.bodyTextStyle,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
