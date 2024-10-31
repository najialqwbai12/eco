// // ignore_for_file: prefer_const_constructors, camel_case_types, prefer_typing_uninitialized_variables
// import 'package:eco2/screen/home.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'login_page.dart';
//
// class createAcunt extends StatefulWidget {
//   const createAcunt({super.key});
//
//   @override
//   State<createAcunt> createState() => _createAcuntState();
// }
//
// class _createAcuntState extends State<createAcunt> {
//   late UserCredential userCredential;
//   var username, myemail, mypassword;
//   GlobalKey<FormState> formstates = GlobalKey<FormState>();
//   singUp() async {
//     dynamic formdata = formstates.currentState;
//     if (formdata.validate()) {
//       formdata.save();
//
//       try {
//         userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//             email: myemail, password: mypassword);
//         return userCredential;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           AwesomeDialog(
//               context: context,
//               title: "error",
//               body: Text("The password provided is too weak"))
//               .show();
//         } else if (e.code == 'email-already-in-use') {
//           AwesomeDialog(
//               context: context,
//               title: "error",
//               body: Text("The account already exists for that email"))
//               .show();
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       print("not valid");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: ListView(children: [
//           SizedBox(
//             height: 30,
//           ),
//           Container(
//             padding: EdgeInsets.all(30),
//             //height: 100,
//             // width: 100,
//             child: Form(
//               key: formstates,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     onSaved: (val) {
//                       username = val;
//                     },
//                     validator: (dynamic val) {
//                       if (val?.length > 100) {
//                         return "userName  larag 100 letter";
//                       }
//                       if (val?.length < 2) {
//                         return "userName  larag 2 letter";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.person),
//                         hintText: "userName",
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(width: 1))),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     onSaved: (val) {
//                       myemail = val;
//                     },
//                     validator: (dynamic val) {
//                       if (val?.length > 100) {
//                         return "email  larag 100 letter";
//                       }
//                       if (val?.length < 4) {
//                         return "email  larag 2 letter";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         hintText: "Eamil",
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(width: 1))),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     onSaved: (val) {
//                       mypassword = val;
//                     },
//                     validator: (dynamic val) {
//                       if (val?.length > 100) {
//                         return "password  larag 100 letter";
//                       }
//                       if (val?.length < 4) {
//                         return " password  larag 4 letter";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.password),
//                         hintText: "passWored",
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(width: 1))),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         UserCredential resopnas = await singUp();
//                         print("+++++++++++++=============++++++++=");
//                         Navigator.of(context).pushReplacementNamed(signIn() as String);
//                         print("++++++++++++++++++++++++");
//                         print("+++++++++++++++++++++===================");
//                       },
//                       child: Text("sing in"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ]));
//   }
// }
