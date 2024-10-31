import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class NumberField extends StatelessWidget {
  const NumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'رقم الجوال',
        suffixText: '966+ ',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال رقم الجوال';
        } else if (value.length != 9) {
          return 'يجب أن يتكون رقم الجوال من 9 أرقام';
        } else if (!value.startsWith('5')) {
          return 'رقم الجوال يجب أن يبدأ بـ 5';
        }
        return null;
      },
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'الايميل',
        suffixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class MyStyledTextFieldSmollNum extends StatefulWidget {
  const MyStyledTextFieldSmollNum({
    super.key,
    required this.text,
    this.mycontroller,
    required this.icon, required TextEditingController controller,
  });

  final String text;
  final TextEditingController? mycontroller;
  final Widget icon;

  @override
  State<MyStyledTextFieldSmollNum> createState() =>
      _MyStyledTextFieldSmollNumState();
}

class _MyStyledTextFieldSmollNumState extends State<MyStyledTextFieldSmollNum> {
  late TextEditingController controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    controller = widget.mycontroller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.mycontroller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال قيمة';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'الرجاء إدخال أرقام فقط';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          prefixIconColor: AppConstants.Color1,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color1, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color3, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
            color: AppConstants.Color3,
          ),
          hintText: widget.text,
          errorText: errorText,
        ),
        onChanged: (value) {
          setState(() {
            errorText = _validateInput(value);
          });
        },
      ),
    );
  }
}

class MyStyledTextFieldSmollEmail extends StatefulWidget {
  const MyStyledTextFieldSmollEmail({
    super.key,
    required this.text,
    this.mycontroller, required TextEditingController controller, required bool readOnly,
    // تم تعديلها هنا لتمرير التحكم في النص
  });

  final String text;
  final TextEditingController? mycontroller; // تم تعديلها هنا

  @override
  State<MyStyledTextFieldSmollEmail> createState() =>
      _MyStyledTextFieldSmollEmailState();
}

class _MyStyledTextFieldSmollEmailState
    extends State<MyStyledTextFieldSmollEmail> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.mycontroller,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.emailAddress,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppConstants.Color1,
            size: 35,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color1, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color3, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
            color: AppConstants.Color3,
          ),
          hintText: widget.text,
        ),
      ),
    );
  }
}

class MyStyledTextFieldSmoll extends StatefulWidget {
  const MyStyledTextFieldSmoll({super.key, required this.text, required this.icon, required TextEditingController controller, required bool readOnly
      // تم تعديلها هنا لتمرير التحكم في النص
      });

  final String text;
  final Widget icon;
  @override
  State<MyStyledTextFieldSmoll> createState() => _MyStyledTextFieldSmollState();
}

class _MyStyledTextFieldSmollState extends State<MyStyledTextFieldSmoll> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          prefixIconColor: AppConstants.Color3,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color1, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.Color3, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
            color: AppConstants.Color3,
          ),
          hintText: widget.text,
        ),
      ),
    );
  }
}

class MyStyledTextFieldSearch extends StatefulWidget {
  const MyStyledTextFieldSearch({super.key, required this.text});
  final String text;
  @override
  State<MyStyledTextFieldSearch> createState() =>
      _MyStyledTextFieldSearchState();
}

class _MyStyledTextFieldSearchState extends State<MyStyledTextFieldSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConstants.Color1, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConstants.Color1, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
