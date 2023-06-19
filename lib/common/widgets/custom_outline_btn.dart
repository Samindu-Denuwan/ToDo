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

  const CustomOutlineBtn(
      {Key? key,
      this.onTap,
      required this.height,
      required this.width,
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
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(
              width: 1,
              color: borderColor,
            )),
        child: Center(
          child: ReusableText(
              text: text, style: appStyle(18.sp, txtColor, FontWeight.w500)),
        ),
      ),
    );
  }
}
