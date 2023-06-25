import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';

class BottomTitles extends StatelessWidget {
  final String text;
  final String text2;
  final Color? color;
  const BottomTitles({Key? key,
    required this.text,
    required this.text2,  this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
          padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer(builder: (context, ref, child) {
            var color = ref.read(todoStateProvider.notifier).getRandomColor();
            return Container(
              height: 80.h,
              width: 5.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                color: color,
              ),

            );
          },),
          const WidthSpacer(width: 15),
          Padding(padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text:text,
                  style: appStyle(24, Colors.white, FontWeight.w500)),
              const HeightSpacer(height: 10),

              ReusableText(
                  text: text2,
                  style: appStyle(12, Colors.white, FontWeight.normal)),
            ],
          ),)
        ],
      ),),


    );
  }
}
