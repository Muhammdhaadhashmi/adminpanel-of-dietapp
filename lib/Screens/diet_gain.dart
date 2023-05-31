import 'package:adminpaneldietapp/Screens/video_player.dart';
import 'package:adminpaneldietapp/Utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Utils/dimensions.dart';
import '../Utils/text_view.dart';
import '../utils/get_handler_controller.dart';

class DietGain extends StatefulWidget {
  final int day;
  final isDietLoss;


   DietGain({Key? key, required this.day, this.isDietLoss}) : super(key: key);

  @override
  State<DietGain> createState() => _DietGainState();
}

class _DietGainState extends State<DietGain> {
  String? value="";
  List ex = [];
  // GetHandlerController controller=Get.put(GetHandlerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: TextView(text: widget.isDietLoss==true?"Diet Gain ":"Diet Loss",),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Diet")
              .doc("Day ${widget.day}")
              .collection("excersice").where("Category",isEqualTo:widget.isDietLoss==false? "Diet Loss":"Diet Gain")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              ex = snapshot.data!.docs;
            }
            return ListView.builder(
                itemCount: ex.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(value: ex[index]["link"])));
                    },
                    // onTap: ()=> launchUrl(Uri.parse(ex[index]["link"])),
                    // child: Text(
                    //  ex[index]["name"],
                    //  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                    child:Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 20, top: 10, bottom: 10),
                      height: 90,
                      width: Dimensions.screenWidth(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
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
                              width: 65,
                            ),
                            Text(ex[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 90),
                              child: IconButton(onPressed: ()async{
                                await FirebaseFirestore.instance.collection('Diet').doc("Day ${widget.day}")
                                    .collection("excersice").doc(ex[index]["ExName"]).delete();
                              }, icon: Icon(Icons.delete,size: 40,)),
                            ),
                            // Text(ex[index]["name"]),
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
          }
      ),
    );
  }
}
