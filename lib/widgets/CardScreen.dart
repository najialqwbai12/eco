import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco2/globals.dart' as globals;

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String _fullName = "جارِ التحميل..."; // الاسم الافتراضي
  String _accountNumber = "**** **** **** ****"; // رقم الحساب الافتراضي

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // جلب بيانات المستخدم من Firebase
  }

  // دالة لجلب بيانات المستخدم من Firebase
  Future<void> _fetchUserData() async {
    try {
      final userId = globals.userId; // الحصول على ID المستخدم
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          _fullName = doc.data()!['fullName'] ?? "اسم غير معروف";
          _accountNumber = doc.data()!['accountNumber'] ?? "**** **** **** ****";
        });
      }
    } catch (e) {
      print("خطأ في جلب بيانات المستخدم: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF0A75B9),
    title: Text("بطاقاتك",
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        )),
    ),
    body:
      SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: DraggableScrollableSheet(
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(243, 245, 248, 1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(

                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                               // backgroundColor: const Color(0xFF0A75B9),
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "مرحباً بك ...معًا لنصون البيئة ونحمي أرضنا",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.lightBlue[900],
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(35, 60, 103, 1),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color.fromRGBO(50, 172, 121, 1),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const Text(
                              "بطاقة توفير",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // عرض رقم الحساب المسترجع من Firebase
                        Text(
                          _accountNumber,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "حامل البطاقة",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // عرض اسم المستخدم المسترجع من Firebase
                                Text(
                                  _fullName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "تنتهي في",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "11/27",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "CVV",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "844",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),


                  Container(
                    child: Text("إعدادات البطاقة", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),),
                    padding: EdgeInsets.symmetric(horizontal: 32),
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey[100]!,
                            spreadRadius: 10.0,
                            blurRadius: 4.5
                        )]
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.wifi_tethering,
                              color: Colors.lightBlue[900],
                            ),
                            SizedBox(
                              width: 16,
                            ),

                            Text("إعدادات البطاقة", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.grey[700]),)

                          ],
                        ),
                        Switch(
                          value: true,
                          activeColor: Color.fromRGBO(50, 172, 121, 1),
                          onChanged: (_) {},
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey[100]!,
                            spreadRadius: 10.0,
                            blurRadius: 4.5
                        )]
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.credit_card,
                              color: Colors.lightBlue[900],
                            ),
                            SizedBox(
                              width: 16,
                            ),

                            Text("الدفع عبر الإنترنت", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.grey[700]),)

                          ],
                        ),
                        Switch(
                          value: true,
                          activeColor: Color.fromRGBO(50, 172, 121, 1),
                          onChanged: (_) {},
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey[100]!,
                            spreadRadius: 10.0,
                            blurRadius: 4.5
                        )]
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.mobile_screen_share,
                              color: Colors.lightBlue[900],
                            ),
                            SizedBox(
                              width: 16,
                            ),

                            Text("السحب من الصراف", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.grey[700]),)

                          ],
                        ),
                        Switch(
                          value: true,
                          activeColor: Color.fromRGBO(50, 172, 121, 1),
                          onChanged: (_) {},
                        )

                      ],
                    ),
                  )


                ],
              ),
            ),
          );
        },
        initialChildSize: 0.95,
        maxChildSize: 0.95,
      ),
    )
    );
  }
}
