import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/widgets/widgets.dart';

class CustomOutlineBtn extends StatelessWidget {
  final void Function()? onTap;
  final double height;
  final double width;
  final Color? backColor;
  final Color borderColor;
  final Color txtColor;
  final String text;
  final double radius;
  final double margin;

  const CustomOutlineBtn(
      {Key? key,
      this.onTap,
        this.radius = 30,
        this.height = 70,
        this.margin = 20,
       this.width = 150,
      this.backColor,
      required this.borderColor,
      required this.txtColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(radius.w),
            border: Border.all(
              width: 1,
              color: borderColor,
            )),
        child: Center(
          child: ReusableText(
              text: text, style: appStyle(20.sp, txtColor, FontWeight.w500)),
        ),
      ),
    );
  }
}
