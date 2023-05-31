import 'package:adminpaneldietapp/Screens/video_player.dart';
import 'package:adminpaneldietapp/Screens/weight_gain.dart';
import 'package:adminpaneldietapp/Utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';

class WeightLoss extends StatefulWidget {
  final int day;
  final isWeightLoss;

  WeightLoss({super.key, required this.day, required this.isWeightLoss});

  @override
  State<WeightLoss> createState() => _WeightLossState();
}

class _WeightLossState extends State<WeightLoss> {
  String? value = "";
  List ex = [];
  List name = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0.0,
        leading: IconButton(
          // alignment: Alignment.topRight,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextView(
          text: widget.isWeightLoss == true ? "Weight Gain " : "Weight Loss",
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("WeightGain")
              .doc("Day ${widget.day}")
              .collection("excersice")
              .where("Category",
                  isEqualTo: widget.isWeightLoss == false
                      ? "Weight Loss"
                      : "Weight Gain")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              ex = snapshot.data!.docs;
              name = snapshot.data!.docs;
            }
            return ListView.builder(
                itemCount: ex.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayer(value: ex[index]["link"])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/bmi.png",
                              height: 60,
                              width: 68,
                            ),
                            Text(
                              ex[index]["name"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 90),
                              child: IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('WeightGain')
                                        .doc("Day ${widget.day}")
                                        .collection("excersice")
                                        .doc(name[index]["ExName"])
                                        .delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 40,
                                  )),
                            ),
                            // Text(ex[index]["link"]),
                            //       var collection = FirebaseFirestore.instance.collection('users');
                            //     var snapshot = await collection.get();
                            //   for (var doc in snapshot.docs) {
                            // await doc.reference.delete();
                            //}
                          ],
                        ),
                      ),
                    ),
                  );
                }
                // child: TextButton(
                //   onPressed: () //     Text(ex[index]["link"]);
                //   },  child: Text(ex[index]["link"], style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
                );
          }),
    );
  }
// body: SafeArea(

//             // Text(days[index]["name"])
//           ],
//         ),
//       ),
//     )
}
