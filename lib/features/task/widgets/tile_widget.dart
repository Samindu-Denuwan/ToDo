import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';

class TileWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? width;
  final bool? isDate;
  const TileWidget({Key? key, required this.icon, required this.text, this.width = 100, this.isDate= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: Colors.black.withOpacity(0.3),
      ),
      width: width!.w,
      child: Padding(
        padding:  EdgeInsets.all(18.w),
        child: Row(
          children: [
            Icon(icon, color: Colors.white,),
            isDate!?WidthSpacer(width: 15): WidthSpacer(width: 5),
            ReusableText(text: text, style: appStyle(20, AppConst.kLight, FontWeight.w500)),
          ],
        ),
      ),



    );
  }
}
