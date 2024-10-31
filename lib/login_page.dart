// import 'package:eco2/screen/home.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'createAcount.dart';
//
//
//   class signIn extends StatefulWidget {
//       const signIn({super.key});
//
//       @override
//       State<signIn> createState() => _signInState();
//       }
//
//       class _signInState extends State<signIn> {
//       late UserCredential userCredential;
//       var myemail, mypassword;
//       GlobalKey<FormState> formstates = GlobalKey<FormState>();
//       singin() async {
//       dynamic formdata = formstates.currentState;
//       if (formdata.validate()) {
//       formdata.save();
//       try {
//       userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: myemail, password: mypassword);
//       } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//       AwesomeDialog(
//       context: context,
//       title: "error",
//       body: const Text("No user found for that email."))
//           .show();
//
//       } else if (e.code == 'wrong-password') {
//       AwesomeDialog(
//       context: context,
//       title: "error",
//       body: const Text("Wrong password provided for that user."))
//           .show();
//       // print('Wrong password provided for that user.');
//       }
//       }
//       print(userCredential.user?.emailVerified);
//       // chack of email
//       if (userCredential.user?.emailVerified == false) {
//       User? user = FirebaseAuth.instance.currentUser;
//       await user?.sendEmailVerification();
//       }
//       } else {
//       print("Not valid");
//       }
//       }
//
//       @override
//       Widget build(BuildContext context) {
//       return  ListView(children: [
//       const SizedBox(
//       height: 30,
//       ),
//       Container(
//       padding: const EdgeInsets.all(30),
//       //height: 100,
//       // width: 100,
//       child: Form(
//       key: formstates,
//       child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       // mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//       TextFormField(
//       onSaved: (val) {
//       myemail = val;
//       },
//       validator: (dynamic val) {
//       if (val?.length > 100) {
//       return "email  larag 100 letter";
//       }
//       if (val?.length < 4) {
//       return "email  larag 2 letter";
//       }
//       return null;
//       },
//       decoration: const InputDecoration(
//       prefixIcon: Icon(Icons.email),
//       hintText: "Eamil",
//       border:
//       OutlineInputBorder(borderSide: BorderSide(width: 1))),
//       ),
//       const SizedBox(
//       height: 20,
//       ),
//       TextFormField(
//       onSaved: (val) {
//       mypassword = val;
//       },
//       validator: (dynamic val) {
//       if (val?.length > 100) {
//       return "password  larag 100 letter";
//       }
//       if (val?.length < 4) {
//       return " password  larag 4 letter";
//       }
//       return null;
//       },
//       decoration: const InputDecoration(
//       prefixIcon: Icon(Icons.password),
//       hintText: "passWored",
//       border:
//       OutlineInputBorder(borderSide: BorderSide(width: 1))),
//       ),
//       const SizedBox(
//       height: 20,
//       ),
//       Center(
//       child: ElevatedButton(
//       onPressed: () async {
//       var user = await singin();
//       if(user !=null){
//       Navigator.of(context).pushReplacementNamed(const createAcunt() as String);
//       }
//       print("+++++++++++++++++++++===================");
//       },
//       child: const Text("sing in"),
//       ),
//       )
//       ],
//       ),
//       ),
//       ),
//       ]
//       );
//       }
//       }
