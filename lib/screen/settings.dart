import 'package:eco2/widgets/card_settings.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'login/loginEcoEarnApp.dart'; // تأكد من أن هذا هو مسار صفحة تسجيل الدخول

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // دالة لعرض معلومات عند الضغط على CardSettings
  void _showInfo(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
            TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // إغلاق النافذة المنبثقة
        },
            child: Text("إغلاق"),
            )],
    );
  },
  );
}

// دالة لتأكيد تسجيل الخروج
void _confirmLogout() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("تأكيد تسجيل الخروج"),
        content: Text("هل تريد تسجيل الخروج؟"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // إغلاق النافذة المنبثقة
            },
            child: Text("لا"),
          ),
          TextButton(
            onPressed: () {
              _logout(); // استدعاء دالة تسجيل الخروج
              Navigator.of(context).pop(); // إغلاق النافذة المنبثقة
            },
            child: Text("نعم"),
          ),
        ],
      );
    },
  );
}

// دالة لتسجيل الخروج
void _logout() {
  // هنا يمكنك إضافة منطق تسجيل الخروج، مثل حذف بيانات المستخدم
  print("تم تسجيل الخروج");

  // توجيه المستخدم إلى صفحة تسجيل الدخول
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );

  // عرض رسالة تأكيد تسجيل الخروج
  _showInfo("تسجيل الخروج", "لقد تم تسجيل خروجك بنجاح.");
}

@override
Widget build(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // العودة إلى الصفحة السابقة
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: AppConstants.Color1,
        centerTitle: true,
        title: Text("الاعدادات"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _showInfo("طرق الدفع", "معلومات حول طرق الدفع المتاحة."),
              child: CardSettings(
                icon: Icon(Icons.payment, size: 50, color: AppConstants.Color2),
                name: "طرق الدفع",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("الاسئلة الشائعة", "إجابة على الأسئلة الشائعة."),
              child: CardSettings(
                icon: Icon(Icons.help_outline, size: 50, color: AppConstants.Color2),
                name: "الاسئلة الشائعة",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("الشروط والاحكام", "تفاصيل الشروط والأحكام."),
              child: CardSettings(
                icon: Icon(Icons.rule, size: 50, color: AppConstants.Color2),
                name: "الشروط والاحكام",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("المساعدة والدعم", "معلومات عن المساعدة والدعم."),
              child: CardSettings(
                icon: Icon(Icons.support, size: 50, color: AppConstants.Color2),
                name: "المساعدة والدعم",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("اللغة", "اختيار اللغة المفضلة."),
              child: CardSettings(
                icon: Icon(Icons.language, size: 50, color: AppConstants.Color2),
                name: "اللغة",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("الدولة", "اختيار الدولة."),
              child: CardSettings(
                icon: Icon(Icons.public, size: 50, color: AppConstants.Color2),
                name: "الدولة",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("استخدام بصمة الوجهة", "معلومات حول استخدام بصمة الوجه."),
              child: CardSettings(
                icon: Icon(Icons.face, size: 50, color: AppConstants.Color2),
                name: "استخدام بصمة الوجهة",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("طرق التواصل", "معلومات حول طرق التواصل."),
              child: CardSettings(
                icon: Icon(Icons.contact_mail, size: 50, color: AppConstants.Color2),
                name: "طرق التواصل",
              ),
            ),
            GestureDetector(
              onTap: () => _showInfo("حذف الحساب", "تحذير حول حذف الحساب."),
              child: CardSettings(
                icon: Icon(Icons.delete_forever, size: 50, color: AppConstants.Color2),
                name: "حذف الحساب",
              ),
            ),
            GestureDetector(
              onTap: _confirmLogout, // استدعاء دالة تأكيد تسجيل الخروج
              child: CardSettings(
                icon: Icon(Icons.logout, size: 50, color: AppConstants.Color2),
                name: "تسجيل الخروج",
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}