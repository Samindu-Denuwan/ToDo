import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/custom_text_field.dart';
import 'package:todo/common/widgets/height_spacer.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/auth/pages/pages.dart';
import 'package:todo/generated/assets.dart';
import 'package:country_picker/country_picker.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _LoginPageState();

}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  Country country = Country(
      phoneCode: "94",
      countryCode: "LK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "LK",
      example: "SRI LANKA",
      displayName: "Sri Lanka",
      displayNameNoCountryCode: "LK",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: ()=>FocusScope.of(context).unfocus(),
              child: ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                     child: Lottie.asset(Assets.animationsLogin),
                  ),
                  const HeightSpacer(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                        text: "Please Enter your Phone Number",
                        style: appStyle(
                            20,
                            AppConst.kLight,
                            FontWeight.w500)),
                  ),
                  const HeightSpacer(height: 30),
                  Center(
                    child: CustomTextField(
                        controller: phoneController,
                        prefixIcon: Container(
                        padding: EdgeInsets.all(14.w),
                        child: GestureDetector(
                          onTap: (){
                            showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  backgroundColor: AppConst.kLight,
                                  searchTextStyle: appStyle(16, Colors.black87, FontWeight.normal),

                                    textStyle: appStyle(16, Colors.black87, FontWeight.normal),
                                  bottomSheetHeight: AppConst.kHeight*0.6,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))
                                ),
                                onSelect: (code){
                                  setState(() {

                                  });
                                });
                          },
                          child: ReusableText(
                              text: "${country.flagEmoji} + ${country.phoneCode}",
                              style: appStyle(18, AppConst.kbkDark, FontWeight.w500)),
                        ),
                      ),
                        keyboard: TextInputType.number,
                        hint: "Enter phone number",
                        style: appStyle(18, Colors.black87, FontWeight.w500),

                    ),
                  ),
                  const HeightSpacer(height: 40),

                ],
              ),
            ),
          ),
      ) ,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(vertical: 30.h, horizontal: 85.w),
        child:  CustomOutlineBtn(
            onTap: (){
              if(phoneController.text.isNotEmpty){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => OtpPage(),));
              }else{

              }
            },
            height: 70,
            borderColor: AppConst.kbkDark,
            backColor: AppConst.kLight,
            radius: 30,
            txtColor: AppConst.kbkDark,
            text: "Send Code"),
      ),
    );
  }
}
