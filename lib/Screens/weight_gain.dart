import 'package:adminpaneldietapp/Screens/weight_loss.dart';
import 'package:adminpaneldietapp/adminpanel/adminlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Utils/app_colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';
import '../utils/get_handler_controller.dart';
import 'diet_plan.dart';

class WeightGain extends StatefulWidget {
  final isWeightGain;
  const WeightGain({Key? key,  required this.isWeightGain}) : super(key: key);

  @override
  State<WeightGain> createState() => _WeightGainState();
}

class _WeightGainState extends State<WeightGain> {
  // GetHandlerController controller=Get.put(GetHandlerController());

  int pageIndex = 0;
  List days = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: TextView(
          text: widget.isWeightGain==true?"Weight Gain ":"Weight Loss",
          // text: "${controller.selectedType.value}"
        ),
      ),
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("WeightGain").orderBy("name")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              days = snapshot.data!.docs;
            }
            return ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeightLoss(
                            isWeightLoss: widget.isWeightGain,
                                day: days[index]["name"],
                              ),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 90,
                    width: Dimensions.screenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage("assets/cal.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/bmi.png",
                          height: 60,
                          width: 60,
                        ),
                        Text("Day ${days[index]["name"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 90),
                        //   child: IconButton(onPressed: ()async{
                        //     await FirebaseFirestore.instance.collection('WeightGain').doc(days[index]['name']).delete();
                        //   }, icon: Icon(Icons.delete,size: 40,)),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 13,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AdminLogin()));
                      pageIndex = 0;
                    });
                  },
                  child: Icon(Icons.home, size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeightGain(isWeightGain: widget.isWeightGain,)));
                      // pageIndex = 1;
                    });
                  },
                  child: Icon(Icons.sports_gymnastics, size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Workout",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DietPlan()));

                      pageIndex = 2;
                    });
                  },
                  child: Icon(Icons.next_plan_outlined, size: 35,)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Diet Plan",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         setState(() {
          //           // Navigator.push(
          //           //     context,
          //           //     MaterialPageRoute(
          //           //         builder: (context) => BmiCalculate()));
          //
          //           pageIndex = 2;
          //         });
          //       },
          //         child: Icon(Icons.calculate, size: 35,)),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Text(
          //       "Calculator",
          //       style: TextStyle(color: Colors.white),
          //     )
          //   ],
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                // onTap: () {
                //   setState(() {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => drawer()));
                //     pageIndex = 3;
                //   });
                // },
                child: Icon(Icons.person, size: 35,),),
              SizedBox(
                height: 5,
              ),
              Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}