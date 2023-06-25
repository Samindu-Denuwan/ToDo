import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/widgets/tile_widget.dart';
import 'package:todo/generated/assets.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';



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
    var scheduledDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var finishTime = ref.watch(finishTimeStateProvider);
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,

        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              ReusableText(text: "Title",
                  style: appStyle(16, AppConst.kLight, FontWeight.w500)),
              const HeightSpacer(height: 10),
              CustomTextField(
                  height: 65,
                  keyboard: TextInputType.text,
                  hint:"Add Title", controller: titleController,
                  hintStyle: appStyle(16, Colors.grey.shade500, FontWeight.w400),
                  style: appStyle(18, AppConst.kGreyLight, FontWeight.w600)),

              const HeightSpacer(height: 20),
              ReusableText(text: "Description",
                  style: appStyle(16, AppConst.kLight, FontWeight.w500)),
              const HeightSpacer(height: 10),
              CustomTextField(
                  height: 150,
                  maxLine: 6,
                  keyboard: TextInputType.text,
                  hint:"Add Description", controller: descController,
                  hintStyle: appStyle(14, Colors.grey.shade500, FontWeight.w400),
                  style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
              const HeightSpacer(height: 30),
              GestureDetector(
                onTap:() async {
                  DateTime? newDate = await showRoundedDatePicker(
                    context: context,
                    barrierDismissible: false,
                    theme: ThemeData(
                        primarySwatch: Colors.orange,
                        brightness: Brightness.dark
                    ),
                    fontFamily: 'Poppins',
                    height: AppConst.kHeight/2.7,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 2),
                    borderRadius: 16,

                  );
                  ref.read(dateStateProvider.notifier).setDate(newDate.toString());

                },
                child: TileWidget(
                    width: AppConst.kWidth,
                    icon: FontAwesome.calendar,
                    text: scheduledDate==''?"Set Date": scheduledDate.substring(0,10)),
              ),
              const HeightSpacer(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:() async {
                      final timeStart = await showRoundedTimePicker(
                        context: context,
                        theme: ThemeData(
                            primarySwatch: Colors.orange,
                            brightness: Brightness.dark
                        ),
                        fontFamily: 'Poppins',
                        initialTime: TimeOfDay.now(),
                      );
                      ref.read(startTimeStateProvider.notifier).setStart(timeStart.toString());
                    },
                    child: TileWidget(
                        width: 150,
                        icon: FontAwesome.clock_o,
                        text: startTime==''?"Start Time": startTime.substring(10,15)
                    ),
                  ),
                  const HeightSpacer(height: 20),
                  GestureDetector(
                    onTap:() async {
                      final timeFinish = await showRoundedTimePicker(
                        context: context,
                        theme: ThemeData(
                            primarySwatch: Colors.orange,
                            brightness: Brightness.dark
                        ),
                        fontFamily: 'Poppins',
                        initialTime: TimeOfDay.now(),
                      );
                      ref.read(finishTimeStateProvider.notifier).setFinish(timeFinish.toString());

                    },
                    child:  TileWidget(
                        width: 150,
                        icon: FontAwesome.clock_o,
                        text: finishTime==''?"End Time": finishTime.substring(10,15)),
                  ),
                ],
              ),

            ],
          ),
        ),
        bottomNavigationBar:  Padding(
          padding:  EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.h),
          child: CustomOutlineBtn(
              onTap: (){},
              margin: 0,
              width: AppConst.kWidth,
              borderColor: Colors.orange,
              backColor: Colors.orange,
              txtColor: Colors.white,
              text: "Add New Task"),
        ),
      ),
    );
  }
}
