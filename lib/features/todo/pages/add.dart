import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/generated/assets.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,

      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              const HeightSpacer(height: 20),
              CustomTextField(
                  height: 65,
                  keyboard: TextInputType.text,
                  hint:"Add Title", controller: titleController,
                  hintStyle: appStyle(16, Colors.grey.shade500, FontWeight.w400),
                  style: appStyle(18, AppConst.kGreyLight, FontWeight.w600)),

              const HeightSpacer(height: 20),
              CustomTextField(
                  height: 150,
                  maxLine: 6,
                  keyboard: TextInputType.text,
                  hint:"Add Description", controller: descController,
                  hintStyle: appStyle(14, Colors.grey.shade500, FontWeight.w400),
                  style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
              const HeightSpacer(height: 30),
               CustomOutlineBtn(
                   onTap: (){},
                  margin: 0,
                  borderColor: Colors.orange,
                  backColor: Colors.orange,
                  txtColor: Colors.white,
                  text: "Set Date"),

              const HeightSpacer(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   CustomOutlineBtn(
                       onTap: (){},
                      margin: 0,
                      borderColor: Colors.orange,
                      backColor: Colors.orange,
                      txtColor: Colors.white,
                      text: "Start Time"),
                   CustomOutlineBtn(
                       onTap: (){},
                      margin: 0,
                      borderColor: Colors.orange,
                      backColor: Colors.orange,
                      txtColor: Colors.white,
                      text: "End Time"),

                ],
              ),
              const HeightSpacer(height: 30),
               CustomOutlineBtn(
                  onTap: (){},
                  margin: 0,
                  borderColor: Colors.transparent,
                  backColor: Colors.green,
                  txtColor: Colors.white,
                  text: "Add New Task"),





            ],
          ),
        ),
      ),
    );
  }
}
