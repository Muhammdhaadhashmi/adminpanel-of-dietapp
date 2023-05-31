import 'package:adminpaneldietapp/Screens/dietplanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/btn.dart';
import '../utils/dimensions.dart';
import '../utils/spaces.dart';
import '../utils/text_edit_field.dart';
import '../utils/text_view.dart';
import '../utils/toast.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // final email = TextEditingController();
  // final password = TextEditingController();

  TextEditingController adminEmail = TextEditingController();
  TextEditingController adminPassword = TextEditingController();

  bool emailvalidate = false;
  bool passvalidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextView(text: "Admin Login"),
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
            height: Dimensions.screenHeight(context),
            width: Dimensions.screenWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  AddVerticalSpace(50),
                  Container(
                    // color: Colors.redAccent,
                    child: ClipRRect(
                      child: Image.asset("assets/logo.png",
                          height: 100, width: 100),
                    ),
                  ),
                  AddVerticalSpace(30),
                  TextEditField(
                    hintText: "Email",
                    cursorColor: AppColors.mainColor,
                    textCapitalization: TextCapitalization.none,
                    preffixIcon:
                        Icon(Icons.email_outlined, color: AppColors.mainColor),
                    textEditingController: adminEmail,
                    errorText: emailvalidate ? "Email Requried" : null,
                    width: Dimensions.screenWidth(context),
                  ),
                  AddVerticalSpace(20),
                  TextEditField(
                    hintText: "Password",
                    cursorColor: AppColors.mainColor,
                    textCapitalization: TextCapitalization.none,
                    preffixIcon:
                        Icon(Icons.lock_outline, color: AppColors.mainColor),
                    textEditingController: adminPassword,
                    width: Dimensions.screenWidth(context),
                    errorText: passvalidate ? "Password Requried" : null,
                    isPassword: true,
                  ),
                  AddVerticalSpace(20),
                  BTN(
                    width: Dimensions.screenWidth(context) - 100,
                    title: "Login",
                    textColor: AppColors.white,
                    color: AppColors.mainColor,
                    fontSize: 15,
                    onPressed: () async {
                      setState(() {
                        if (adminEmail.text.isEmpty) {
                          emailvalidate = true;
                        } else if (adminPassword.text.isEmpty) {
                          passvalidate = true;
                        } else {
                          emailvalidate = false;
                          passvalidate = false;
                        }
                      });
                      if (adminEmail.text.isNotEmpty &&
                          adminPassword.text.isNotEmpty) {
                        try {
                          await FirebaseFirestore.instance
                              .collection("Admin")
                              .doc("AdminLogin")
                              .snapshots()
                              .forEach((element) {
                            if (element.data()?["adminEmail"] ==
                                    adminEmail.text &&
                                element.data()?["adminPassword"] ==
                                    adminPassword.text) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DietPLanner()),
                                  (route) => false);
                            }
                          });
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == 'user-not-found') {
                            FlutterErrorToast(error: "Invalid Email");
                          } else if (e.code == 'wrong-password') {
                            FlutterErrorToast(error: "Invalid Password");
                          }

                          setState(() {
                            emailvalidate = false;
                            passvalidate = false;
                            // email.text = "";
                            // password.text = "";
                          });
                        }
                      }
                    },
                    // onPressed: ()async{

                    //
                    // },
                  ),
                ]))));
  }
}
