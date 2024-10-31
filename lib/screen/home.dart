import 'package:eco2/screen/tawtheeq_page.dart';
import 'package:eco2/screen/welcome/NotificationsPage.dart';
import 'package:flutter/material.dart';
import 'package:eco2/constants/app_constants.dart';
import '../widgets/card_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد Firebase Firestore
import 'package:eco2/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';

import 'MapPage.dart';
import 'offers.dart';

class HomePage extends StatelessWidget {
  final String? userId = globals.userId;
  final ImagePicker _picker = ImagePicker();
  Future<Map<String, dynamic>> getUserData() async {
    final doc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'profileImage': 'images/profile.jpg', // الصورة الافتراضية
        'accountNumber': 'غير متاح', // يمكنك إضافة بيانات أخرى هنا
        'points': 0.0, // نقطة افتراضية
      });
    }

    return doc.data() ?? {};
  }
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: globals.userId)
        .orderBy('date', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  Future<void> updateUserImage(String imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profileImage': imageUrl, // تأكد من أن لديك عمود 'profileImage' في Firestore
    });
  }
  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // استخدام pickImage بدلاً من getImage
    if (pickedFile != null) {
      // هنا يمكنك رفع الصورة إلى Firebase Storage والحصول على رابطها
      String imageUrl = pickedFile.path; // استبدل هذا برابط الصورة بعد رفعها
      await updateUserImage(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تحديث الصورة بنجاح')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("حدث خطأ في جلب البيانات"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد بيانات متاحة"));
          }

          final userData = snapshot.data!;
          final accountNumber = userData['accountNumber'] ?? 'غير متاح';
          //final points = userData['points']?.toString() ?? '0.0';
          final points = (userData['points']?.toDouble() ?? 0.0).toStringAsFixed(2);
          final profileImage = userData['profileImage'] ?? "images/profile.jpg";
          return Directionality(

            // إضافة Directionality هنا
              textDirection: TextDirection.ltr, // تعيين الاتجاه إلى LTR
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Color.fromRGBO(38, 81, 158, 1),
                child: Stack(
                  children: <Widget>[
                    // الحاوية للبيانات العلوية
                    Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                      child: Column(
                        // backgroundColor: Color.fromRGBO(38, 81, 158, 1),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "$points ECO",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Colors.lightBlue[100],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => NotificationsPage()),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    GestureDetector(
                                      onTap: () => pickImage(context), // تغيير الصورة عند النقر
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: Image.asset(
                                            profileImage,
                                            fit: BoxFit.cover, // تصغير الصورة لتناسب المربع
                                            width: 50, // عرض الصورة
                                            height: 50, // ارتفاع الصورة
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment:
                                Alignment.center, // محاذاة الحاوية في الوسط
                                child: Text(
                                  "رقم الحساب : $accountNumber",
                                  textAlign:
                                  TextAlign.center, // محاذاة النص في الوسط
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.blue[100],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                          Color.fromRGBO(243, 245, 248, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.blue[900],
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // الانتقال إلى الصفحة الثانية عند الضغط
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TawtheeqPage()),
                                        );
                                      },
                                      child: Text(
                                        "التوثيق",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.blue[100],
                                         // color: Colors.blue, // لون أزرق للإشارة إلى أنه رابط
                                         // decoration: TextDecoration.underline, // خط تحت النص
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "إرسال",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w700,
                                    //       fontSize: 14,
                                    //       color: Colors.blue[100]),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                          Color.fromRGBO(243, 245, 248, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.blue[900],
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // الانتقال إلى الصفحة الثانية عند الضغط
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MapPage()),
                                        );
                                      },
                                      child: Text(
                                        "الخريطه",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.blue[100],
                                          // color: Colors.blue, // لون أزرق للإشارة إلى أنه رابط
                                          // decoration: TextDecoration.underline, // خط تحت النص
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                          Color.fromRGBO(243, 245, 248, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Icon(
                                        Icons.local_offer_outlined,
                                        color: Colors.blue[900],
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "عروض",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.blue[100]),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                          Color.fromRGBO(243, 245, 248, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Icon(
                                        Icons.local_grocery_store_outlined,
                                        color: Colors.blue[900],
                                        size: 30,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // الانتقال إلى الصفحة الثانية عند الضغط
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => offersPage()),
                                        );
                                      },
                                      child: Text(
                                        "المتجر",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.blue[100],
                                          // color: Colors.blue, // لون أزرق للإشارة إلى أنه رابط
                                          // decoration: TextDecoration.underline, // خط تحت النص
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "إرسال",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w700,
                                    //       fontSize: 14,
                                    //       color: Colors.blue[100]),
                                    // ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   child: Column(
                              //     children: <Widget>[
                              //       Container(
                              //         decoration: BoxDecoration(
                              //             color:
                              //             Color.fromRGBO(243, 245, 248, 1),
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(18))),
                              //         child: Icon(
                              //           Icons.local_grocery_store_outlined,
                              //           color: Colors.blue[900],
                              //           size: 30,
                              //         ),
                              //         padding: EdgeInsets.all(12),
                              //       ),
                              //       SizedBox(
                              //         height: 4,
                              //       ),
                              //       Text(
                              //         "المتجر",
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.w700,
                              //             fontSize: 14,
                              //             color: Colors.blue[100]),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                    ),

                    // الحاوية السفلية القابلة للسحب
                    DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "سجل المعاملات",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "عرض الكل",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.grey[800]),
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                ),
                                SizedBox(
                                  height: 24,
                                ),

                                // الحاوية للأزرار
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "الكل",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.grey[900]),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 4.5)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "CLS",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.grey[900]),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 4.5)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "PR",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.grey[900]),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 4.5)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "ORG",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.grey[900]),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 10.0,
                                                  spreadRadius: 4.5)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 16,
                                ),

                                // قائمة المعاملات اليوم
                                Container(
                                  child: Text(
                                    "اليوم",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[500]),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                ),

                                SizedBox(
                                  height: 16,
                                ),

                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 32),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(18))),
                                            child: Icon(
                                              Icons.call_received,
                                              color: Colors.lightBlue[900],
                                            ),
                                            padding: EdgeInsets.all(12),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "استلام نقاط",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.grey[900]),
                                                ),
                                                Text(
                                                  " CLS وارد من",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.grey[500]),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "\+24.0 ECO",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.green),
                                              ),
                                              Text(
                                                "26 يوليو",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[500]),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  padding: EdgeInsets.all(0),
                                  controller:
                                  ScrollController(keepScrollOffset: false),
                                ),

                                SizedBox(
                                  height: 16,
                                ),

                                // قائمة المعاملات أمس
                                Container(
                                  child: Text(
                                    "أمس",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[500]),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                ),

                                SizedBox(
                                  height: 16,
                                ),

                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 32),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(18))),
                                            child: Icon(
                                              Icons.call_made,
                                              color: Color(
                                                  0xFFD9900A), // Corrected color format
                                            ),
                                            padding: EdgeInsets.all(12),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "رسوم مشتريات",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.grey[900]),
                                                ),
                                                Text(
                                                  "Ria Coffy تحويل ل ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.grey[500]),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "\-12.0 ECO",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "25 يوليو",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[500]),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: 2,
                                  padding: EdgeInsets.all(0),
                                  controller:
                                  ScrollController(keepScrollOffset: false),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      initialChildSize: 0.65,
                      minChildSize: 0.55,
                      maxChildSize: 1,
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetchNotifications(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text(""));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text("لا توجد إشعارات"));
                        }

                        final notifications = snapshot.data!;

                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return ListTile(
                              title: Text(notification['message']),
                              subtitle: Text(notification['date'].toDate().toString()),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ));
        });
  }
}
