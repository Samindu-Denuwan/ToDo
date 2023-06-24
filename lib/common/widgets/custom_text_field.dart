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
  final int maxLine;
  final bool? boxShadow;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const CustomTextField({Key? key,
    required this.keyboard,
    required this.hint,
    this.suffixIcon,
    this.boxShadow = false,
    this.maxLine =1,
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
          boxShadow: [
           if (boxShadow == true) BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.4)
            ) else BoxShadow(
             )

          ]
      ),

      child: TextFormField(
        controller: controller,
        cursorHeight: 25.h,
        maxLines: maxLine,
        onChanged: onChanged,
        keyboardType: keyboard,
        style: style,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            suffixIconColor: AppConst.kbkDark,
            prefixIcon: prefixIcon,
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none
            ),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none
            )
        ),
      ),
    );
  }
}
