import 'package:adminpaneldietapp/Screens/diet.dart';
import 'package:adminpaneldietapp/Screens/weight_gain.dart';
import 'package:flutter/material.dart';

import '../adminpanel/adminlogin.dart';
import '../utils/app_colors.dart';
import '../utils/btn.dart';
import '../utils/dimensions.dart';
import '../utils/spaces.dart';
import '../utils/text_view.dart';
import 'diet_plan.dart';
import 'exercise.dart';

class DietPLanner extends StatefulWidget {
  const DietPLanner({Key? key}) : super(key: key);

  @override
  State<DietPLanner> createState() => _DietPLannerState();
}

class _DietPLannerState extends State<DietPLanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          // alignment: Alignment.topRight,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminLogin()));
          },
        ),
        title: TextView(text: "Choose Your Plan"),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
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
                      ClipRRect(
                        child: Image.asset("assets/logo.png",
                            height: 100, width: 100),
                      ),
                      AddVerticalSpace(40),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "Enter Exercise",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterExercise()));
                        },
                      ),
                      AddVerticalSpace(45),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "Enter Diet",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterDiet()));
                        },
                      ),
                      AddVerticalSpace(45),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "View Weight Gain",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WeightGain(isWeightGain: true,)));
                        },
                      ),   AddVerticalSpace(30),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "View Weight Loss",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WeightGain(isWeightGain: false,)));
                        },
                      ),
                      AddVerticalSpace(30),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "View Diet Gain",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DietPlan(isDietGain: true,)));
                        },
                      ),
                      AddVerticalSpace(30),
                      BTN(
                        width: Dimensions.screenWidth(context) - 100,
                        title: "View Diet Loss",
                        textColor: AppColors.white,
                        color: AppColors.mainColor,
                        fontSize: 15,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DietPlan(isDietGain: false,)));
                        },
                      ),
                    ])))
    );

  }
}
