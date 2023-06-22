import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';

class TodoTile extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;
  const TodoTile({Key? key, this.color,  this.title, this.description, this.start, this.end, this.editWidget, this.delete, this.switcher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            width: AppConst.kWidth,
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppConst.kGreyLight,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        //TODO: dynamic colors
                        color: color?? Colors.red,
                      ),

                    ),
                    WidthSpacer(width: 15),
                    Padding(padding: EdgeInsets.all(8.w),
                    child: SizedBox(
                      width: AppConst.kWidth*0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: title??"Title of Todo",
                              style: appStyle(18, Colors.white, FontWeight.w500)),
                          HeightSpacer(height: 3),
                          ReusableText(text: description??"Description of Todo",
                              style: appStyle(14, Colors.white, FontWeight.normal)),
                          HeightSpacer(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: AppConst.kWidth*0.3,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.3,
                                    color: AppConst.kGreyDk
                                  ),
                                  borderRadius: BorderRadius.circular(12.w),
                                  color: AppConst.kbkDark
                                ),
                                child: Center(
                                  child: ReusableText(
                                      text:"$start | $end",
                                      style: appStyle(12, Colors.white, FontWeight.normal)),
                                ),
                              ),
                              WidthSpacer(width: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    child: editWidget,
                                  ),
                                  WidthSpacer(width: 20),
                                  GestureDetector(
                                    onTap: delete,
                                    child: Icon(MaterialCommunityIcons.delete_circle),


                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
