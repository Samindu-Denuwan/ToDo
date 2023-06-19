import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableText(
              text: "CheckMate",
              style: appStyle(
                  26,
                  AppConst.kBlueLight,
                  FontWeight.w600)),
          WidthSpacer(width: 50),
          ReusableText(
              text: "CheckMate",
              style: appStyle(
                  26,
                  AppConst.kBlueLight,
                  FontWeight.w600)),
        ],
      ),
    );
  }
}


