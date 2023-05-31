import 'package:adminpaneldietapp/Screens/dietplanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/app_colors.dart';
import '../Utils/btn.dart';
import '../Utils/dimensions.dart';
import '../Utils/spaces.dart';
import '../Utils/text_edit_field.dart';
import '../Utils/text_view.dart';
import '../utils/get_handler_controller.dart';

class EnterExercise extends StatefulWidget {
  const EnterExercise({Key? key}) : super(key: key);

  @override
  State<EnterExercise> createState() => _EnterExerciseState();
}

class _EnterExerciseState extends State<EnterExercise> {
  // bool isChecked = false;
  bool dayvalidate = false;
  bool exercisevalidate = false;

  bool namevalidate = false;
  bool linkvalidate = false;
  // bool imgvalidate = false;

  final TextEditingController days = new TextEditingController();
  final TextEditingController Exercises = new TextEditingController();

  final TextEditingController dayname = new TextEditingController();
  final TextEditingController Name = new TextEditingController();
  final TextEditingController Link = new TextEditingController();
  // GetHandlerController controller=Get.put(GetHandlerController());
  // final TextEditingController Exercise1 = new TextEditingController();
  // // final TextEditingController Exercise2 = new TextEditingController();
  // bool catValid = false;
  String selected = '';
  List exercise = [
   "Weight Loss",
    "Weight Gain",
  ];
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DietPLanner()));
            },
          ),
          title: TextView(text: "Enter Exercises"),
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: Dimensions.screenHeight(context),
            width: Dimensions.screenWidth(context),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AddVerticalSpace(20),
                    Text(
                      "Days",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    AddVerticalSpace(50),
                    TextEditField(
                      hintText: "Days",
                      cursorColor: AppColors.mainColor,
                      textCapitalization: TextCapitalization.none,
                      preffixIcon: Icon(
                        Icons.view_day,
                        color: AppColors.mainColor,
                      ),
                      textEditingController: days,
                      errorText: dayvalidate ? "DaY Requried" : null,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(20),
                         SizedBox(
                            height: 70,
                            child: DropdownButtonFormField2(
                              buttonPadding: EdgeInsets.only(
                                right: 10,
                              ),

                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                              ),
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Icon(
                                    Icons.category,
                                    color: AppColors.mainColor,
                                  ),
                                  AddHorizontalSpace(10),
                                  TextView(
                                    text: 'Select Option ',
                                    fontSize: 14,
                                    // color: catValid
                                    //     ? AppColors.red
                                    //     : AppColors.grey,
                                  ),
                                ],
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.grey,
                              ),
                              iconSize: 30,
                              buttonHeight: 55,
                              // buttonPadding:
                              // const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: exercise
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.sports_gymnastics,
                                              color: AppColors.mainColor,
                                            ),
                                            AddHorizontalSpace(10),
                                            TextView(
                                              text: item,
                                              fontSize: 14,
                                              color: AppColors.grey,
                                            ),
                                          ],
                                        ),
                                      )).toList(),
                              // validator: (value) {
                              //   if (value == null) {
                              //     return 'Please select Days.';
                              //   }
                              // },
                              onChanged: (value) {
                                setState(() {
                                  selected = value!;
                                  // controller.selectedType.value=value;
                                });
                                //Do something when changing the item if you want.
                              },
                            ),
                          ),
                    AddVerticalSpace(20),
                    Text(
                      "Exercises",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    AddVerticalSpace(20),
                    TextEditField(
                      hintText: "Exercise",
                      cursorColor: AppColors.mainColor,
                      textCapitalization: TextCapitalization.none,
                      preffixIcon: Icon(Icons.fitness_center,
                          color: AppColors.mainColor),
                      textEditingController: Exercises,
                      errorText: exercisevalidate ? "Exercise Requried" : null,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(50),
                    TextEditField(
                      hintText: "Name",
                      cursorColor: AppColors.mainColor,
                      textCapitalization: TextCapitalization.none,
                      preffixIcon:
                          Icon(Icons.person, color: AppColors.mainColor),
                      textEditingController: Name,
                      errorText: namevalidate ? "name Requried" : null,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(50),
                    TextEditField(
                      hintText: "Link",
                      cursorColor: AppColors.mainColor,
                      textCapitalization: TextCapitalization.none,
                      preffixIcon: Icon(Icons.link, color: AppColors.mainColor),
                      textEditingController: Link,
                      errorText: linkvalidate ? "link Requried" : null,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(20),
                    BTN(
                      width: Dimensions.screenWidth(context) - 100,
                      title: "Submit Exercise",
                      textColor: AppColors.white,
                      color: AppColors.mainColor,
                      fontSize: 15,
                      onPressed: () async {
                         await FirebaseFirestore.instance.collection("WeightGain").doc("Day ${days.text}").
                         set({
                            "name": int.parse(days.text)}).
                         then((value) async {
                           await FirebaseFirestore.instance.collection("WeightGain").doc("Day ${days.text}").collection("excersice")
                               .doc("${Exercises.text}").set({
                             // "Exercise":Exercises.text,
                             "name": Name.text,
                             "link": Link.text,
                             "ExName": Exercises.text,
                             "Category":selected,
                           });
                         });

                        Fluttertoast.showToast(
                            msg: 'Your Exercise Stored',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.mainColor,
                            textColor: Colors.white,
                            fontSize: 10.0);

                         days.clear();
                        Name.clear();
                        Exercises.clear();
                        Link.clear();
                      },
                    ),
                  ]),
            )));
  }
}
