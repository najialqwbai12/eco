import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/app_constants.dart';
import '../widgets/CardScreen.dart';
import 'package:eco2/globals.dart' as globals;

import '../widgets/card_home.dart';

class offersPage extends StatefulWidget {
  const offersPage({super.key});

  @override
  State<offersPage> createState() => _offersPageState();
}

class _offersPageState extends State<offersPage> {
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  String searchQuery = '';
  List<int> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        filteredProducts = products;
      });
    } else {
      throw Exception('فشل في تحميل المنتجات');
    }
  }
  Future<void> addNotification(String message) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': globals.userId,
      'message': message,
      'date': DateTime.now(),
    });
  }
  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = products.where((product) {
        return product['title'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void toggleProductSelection(int productId) {
    setState(() {
      if (selectedProducts.contains(productId)) {
        selectedProducts.remove(productId);
      } else {
        selectedProducts.add(productId);
      }
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var product in filteredProducts) {
      if (selectedProducts.contains(product['id'])) {
        total += product['price'];
      }
    }
    return total;
  }

  Future<bool> processPurchase(double totalPrice) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(globals.userId)
          .get();

      double currentPoints = doc['points']?.toDouble() ?? 0.0;

      if (currentPoints >= totalPrice) {
        double newPoints = currentPoints - totalPrice;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(globals.userId)
            .update({'points': newPoints});

        await FirebaseFirestore.instance.collection('transactions').add({
          'userId': globals.userId,
          'message': "-$totalPrice ECO",
          'date': DateTime.now(),
        });

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("حدث خطأ: $e");
      return false;
    }
  }
  // void buySelectedProducts() async {
  //   if (selectedProducts.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("يرجى تحديد منتجات للشراء!"),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     return; // إنهاء الدالة إذا لم يتم تحديد أي منتجات
  //   }
  //
  //   double total = calculateTotalPrice();
  //
  //   bool success = await processPurchase(total);
  //
  //   if (success) {
  //     // إنشاء قائمة من CardItem بدلاً من List<dynamic>
  //     List<CardItem> purchasedProducts = filteredProducts.where((product) {
  //       return selectedProducts.contains(product['id']);
  //     }).map((product) {
  //       return CardItem(
  //         image: product['image'],
  //         title: product['title'],
  //         price: product['price'],
  //       );
  //     }).toList();
  //
  //     // إعادة تعيين قائمة selectedProducts
  //     setState(() {
  //       selectedProducts.clear(); // إلغاء التحديد
  //     });
  //
  //     // الانتقال إلى CardHome مع قائمة CardItem
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => CardHome(items: purchasedProducts),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("الرصيد غير كافٍ!"),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
  void buySelectedProducts() async {
    // تحقق مما إذا كانت هناك منتجات محددة
    if (selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("يرجى تحديد منتجات للشراء!"),
          duration: Duration(seconds: 2),
        ),
      );
      return; // إنهاء الدالة إذا لم يتم تحديد أي منتجات
    }

    double total = calculateTotalPrice();

    bool success = await processPurchase(total);

    if (success) {
      await addNotification("تم شراء منتجات بقيمة ${total.toStringAsFixed(2)} ECO");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("تم الشراء"),
            content: Text("تمت العملية بنجاح!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("موافق"),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("الرصيد غير كافٍ!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          //leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          backgroundColor: AppConstants.Color1,
          centerTitle: true,
          title: Text("المتجر"),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => CardScreen()),
                // );
              },
              icon: Icon(Icons.list),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    "إجمالي السعر: SAR ${calculateTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      onChanged: searchProducts,
                      decoration: InputDecoration(
                        hintText: "بحث",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: buySelectedProducts,
                    child: Text("شراء"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppConstants.Color1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: filteredProducts.map((product) {
                  return buildProductCard(
                    product['image'],
                    product['title'],
                    product['price'],
                    product['id'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(String image, String title, num price, int productId) {
    bool isSelected = selectedProducts.contains(productId);
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.network(image, width: 80, height: 80),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("السعر: SAR ${price.toStringAsFixed(2)}"),
              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              toggleProductSelection(productId);
            },
          ),
        ],
      ),
    );
  }
}
