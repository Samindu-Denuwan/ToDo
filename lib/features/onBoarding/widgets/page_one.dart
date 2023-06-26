import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/widgets/height_spacer.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/generated/assets.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kGreyBk,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.w, ),
            child: Image.asset(Assets.imageTodo1, fit: BoxFit.cover,),
          ),
          const HeightSpacer(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(text: "ToDo CheckMate", style: appStyle(
                  30, AppConst.kLight, FontWeight.w600)),
              const HeightSpacer(height: 10),
              Padding(
              padding: EdgeInsets.symmetric(
              horizontal: 30.w,),
              child: Text(
               "Welcome!! Do you want to create a task fast and with ease",
                 textAlign: TextAlign.center,
                  style: appStyle(16, AppConst.kGreyLight, FontWeight.normal),
               ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
