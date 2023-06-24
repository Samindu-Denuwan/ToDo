import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';

class TileWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? width;
  const TileWidget({Key? key, required this.icon, required this.text, this.width = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          color: Colors.grey
      ),
      width: width!.w,
      child: Padding(
        padding:  EdgeInsets.all(10.w),
        child: Row(
          children: [
            Icon(icon, color: Colors.white,),
            WidthSpacer(width: 10),
            ReusableText(text: text, style: appStyle(16, AppConst.kLight, FontWeight.w500)),
          ],
        ),
      ),



    );
  }
}
