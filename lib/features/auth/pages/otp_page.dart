import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/height_spacer.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';
import 'package:todo/generated/assets.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerWidget {
  final String smsCodeId;
  final String phone;



  const OtpPage({Key? key, required this.smsCodeId, required this.phone}) : super(key: key);

  void verifyOtpCode(
     BuildContext context,
    WidgetRef ref, String smsCode
  ){
    ref.read(authControllerProvider).verifyOtpCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppConst.kGreyBk,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: AppConst.kGreyBk,
              systemNavigationBarIconBrightness: Brightness.light
          ),


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
                        return verifyOtpCode(context, ref, value);
                      }
                    },
                    onSubmitted: (value){
                      if(value.length == 6){
                        return verifyOtpCode(context, ref, value);
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
