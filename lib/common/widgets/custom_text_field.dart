import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboard;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle style;
  final double height;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const CustomTextField({Key? key,
    required this.keyboard,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon, this.hintStyle, required this.controller,
    required this.style, this.onChanged,
    this.height = 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height.h,
      width: AppConst.kWidth*0.9,
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),

      child: TextFormField(
        controller: controller,
        cursorHeight: 25.h,
        maxLines: 1,
        onChanged: onChanged,
        keyboardType: keyboard,
        style: style,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            suffixIcon: suffixIcon,
            suffixIconColor: AppConst.kbkDark,
            prefixIcon: prefixIcon,
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: AppConst.kRed,
                  width: 0.5,
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.5,
                )
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: AppConst.kRed,
                  width: 0.5,
                )
            ),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: AppConst.kGreyDk,
                  width: 0.5,
                )
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: AppConst.kbkDark,
                  width: 0.5,
                )
            )
        ),
      ),
    );
  }
}
