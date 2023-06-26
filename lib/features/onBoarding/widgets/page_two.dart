import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/auth/pages/login_page.dart';
import 'package:todo/generated/assets.dart';
import '../../../common/widgets/widgets.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

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
            child: Image.asset(Assets.imageTodo2, fit: BoxFit.cover,),
          ),
          const HeightSpacer(height: 50),
          CustomOutlineBtn(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const LoginPage(),));
            },
              radius: 30,
              width: AppConst.kWidth*0.9,
              borderColor: AppConst.kLight,
              txtColor: AppConst.kLight,
              text: "Login with phone number")
        ],
      ),
    );
  }
}
