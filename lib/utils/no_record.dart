
import 'package:adminpaneldietapp/utils/spaces.dart';
import 'package:adminpaneldietapp/utils/text_view.dart';
import 'package:flutter/cupertino.dart';


import 'app_colors.dart';
import 'dimensions.dart';

class NoRecord extends StatelessWidget {
  const NoRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Dimensions.screenHeight(context) / 2,
        width: Dimensions.screenWidth(context),
        // color: AppColors.pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              height: 70,
              width: 70,
              "assets/Images/nocloud.png",
              color: AppColors.mainColor,
            ),
            AddVerticalSpace(10),
            TextView(
              text: "No Record",
              color: AppColors.mainColor,
            )
          ],
        ));
  }
}
