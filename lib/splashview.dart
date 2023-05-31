import 'dart:async';
import 'package:adminpaneldietapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'adminpanel/adminlogin.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
