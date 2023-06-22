import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/titles.dart';


class CustomExpansionTile extends StatelessWidget {
  final String text;
  final String text2;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  const CustomExpansionTile({Key? key, required this.text, required this.text2, required this.children, this.onExpansionChanged, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.kGreyDk,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
              title: BottomTitles(text: text, text2: text2),
            children: children,
            childrenPadding: EdgeInsets.zero,
            onExpansionChanged: onExpansionChanged,
            controlAffinity: ListTileControlAffinity.trailing,
            trailing: trailing,


          ),
      ),
    );
  }
}
