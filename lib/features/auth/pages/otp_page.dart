import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/height_spacer.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/generated/assets.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,

      ),
      body: SafeArea(
          child: GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ReusableText(text: "Enter your OTP",
                      style: appStyle(25, Colors.white, FontWeight.w500)),
                  const HeightSpacer(height: 30),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    animationCurve: Curves.bounceIn,
                    autofocus: true,
                    defaultPinTheme: PinTheme(
                        textStyle: appStyle(45, Colors.white, FontWeight.w500),
                        width:50.w,
                        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.w)

                        )

                    ),
                    onCompleted: (value){
                      if(value.length == 6){

                      }
                    },
                    onSubmitted: (value){
                      if(value.length == 6){

                      }
                    },

                  ),

                  SizedBox(
                    height:AppConst.kHeight/3,
                      width: AppConst.kWidth,
                      child: Lottie.asset(Assets.animationsLogin,
                        fit: BoxFit.cover
                          )),




                ],
              ),
            ),
          )
      ),
    );
  }
}
