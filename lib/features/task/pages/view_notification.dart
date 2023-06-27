import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/height_spacer.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/generated/assets.dart';

class NotificationsPage extends StatelessWidget {
  final String? payload;
  const NotificationsPage({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var date = payload!.split('|')[2];
    var start = payload!.split('|')[3];
    var finish = payload!.split('|')[4];

    return Scaffold(
      backgroundColor: AppConst.kGreyBk,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Container(
                  width: AppConst.kWidth,
                  height: AppConst.kHeight*0.7,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(text: "Reminder",
                            style: appStyle(40, AppConst.kLight, FontWeight.w600)),
                        const HeightSpacer(height: 15),
                        Container(
                          width: AppConst.kWidth,
                          padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:BorderRadius.circular(15.w) ,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ReusableText(text: "Today",
                                  style: appStyle(14, AppConst.kGreyBk, FontWeight.w500)),
                           const WidthSpacer(width: 15),
                              ReusableText(text: "From: $start  To: $finish",
                                  style: appStyle(16, AppConst.kGreyBk, FontWeight.w600)),
                            ],
                          ),
                        ),
                        const HeightSpacer(height: 20),
                        ReusableText(text: title,
                            style: appStyle(25, Colors.white.withOpacity(0.7), FontWeight.w600)),
                        const HeightSpacer(height: 10),
                        Text(
                            desc,
                          maxLines: 8,
                          textAlign: TextAlign.justify,
                          style: appStyle(16, Colors.grey.shade300, FontWeight.w500),
                        ),

                      ],
                    ),
                  ),

                ),
              ),
              Positioned(
                right: -5.w,
                  top: -55.h,
                  child: Container(
                    width: 140.w,
                      height: 140.h,
                      child: Lottie.asset(

                          Assets.animationsBell,
                          fit: BoxFit.cover))),

              Positioned(
                  bottom: AppConst.kHeight*0.130,
                  left: 0,
                  right: 15,
                  child: Container(
                      width: 140.w,
                      height: 140.h,
                      child: Lottie.asset(
                          Assets.animationsCheckNoti,
                          fit: BoxFit.cover))),


            ],
          ),),
    );
  }
}
