import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;
import 'package:todo/common/helpers/notification_helper.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/dates/dates_provider.dart';
import 'package:todo/features/task/controllers/pending/count_provider.dart';
import 'package:todo/features/task/pages/home_page.dart';
import 'package:todo/features/task/widgets/tile_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class AddTask extends ConsumerStatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  List<int>notifications = [];
  late NotificationHelper notifierHelper;
  late NotificationHelper controller;

  @override
  void initState() {
    notifierHelper = NotificationHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0), (){
      controller = NotificationHelper(ref: ref);
    });
   notifierHelper.initializeNotifications();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var scheduledDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var finishTime = ref.watch(finishTimeStateProvider);


    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppConst.kGreyBk,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: AppConst.kGreyBk,
              systemNavigationBarIconBrightness: Brightness.light
          ),

        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: "Title",
                        style: appStyle(16, AppConst.kLight, FontWeight.w500)),
                    const HeightSpacer(height: 20),
                    CustomTextField(
                        height: 65,
                        keyboard: TextInputType.text,
                        hint:"Add Title", controller: titleController,
                        hintStyle: appStyle(16, Colors.grey.shade500, FontWeight.w400),
                        style: appStyle(18, AppConst.kGreyLight, FontWeight.w600)),

                    const HeightSpacer(height: 20),
                    ReusableText(text: "Description",
                        style: appStyle(16, AppConst.kLight, FontWeight.w500)),
                    const HeightSpacer(height: 20),
                    CustomTextField(
                        height: 150,
                        maxLine: 6,
                        keyboard: TextInputType.text,
                        hint:"Add Description", controller: descController,
                        hintStyle: appStyle(16, Colors.grey.shade500, FontWeight.w400),
                        style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
                    const HeightSpacer(height: 20),
                    ReusableText(text: "Select Date",
                        style: appStyle(16, AppConst.kLight, FontWeight.w500)),
                    const HeightSpacer(height: 20),
                    GestureDetector(
                      onTap:() async {
                        FocusScope.of(context).unfocus();
                        DateTime? newDate = await showRoundedDatePicker(
                          context: context,
                          barrierDismissible: false,
                          theme: ThemeData(
                              primarySwatch: Colors.orange,
                              brightness: Brightness.dark
                          ),
                          fontFamily: 'Poppins',
                          height: AppConst.kHeight/2.85,
                          styleDatePicker: MaterialRoundedDatePickerStyle(
                              paddingDateYearHeader: EdgeInsets.all(5.w),
                          paddingMonthHeader: EdgeInsets.symmetric(vertical: 5.h),
                          paddingActionBar: EdgeInsets.zero),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 1)),
                          lastDate: DateTime(DateTime.now().year + 2),
                          borderRadius: 16,
                        );
                       newDate!=null? ref.read(dateStateProvider.notifier).setDate(newDate.toString()):"";
                      },
                      child: TileWidget(
                        isDate: true,
                          width:AppConst.kWidth,
                          icon: FontAwesome.calendar,
                          text: scheduledDate==''?"Set Date": scheduledDate.substring(0,10)),
                    ),
                    const HeightSpacer(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Start Time",
                                style: appStyle(16, AppConst.kLight, FontWeight.w500)),
                            const HeightSpacer(height: 20),
                            GestureDetector(
                              onTap:() async {
                                picker.DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(DateTime.now().year+2),
                                    onConfirm: (s_time) {
                                      ref.read(startTimeStateProvider.notifier).setStart(s_time.toString());
                                    notifications =  ref.read(startTimeStateProvider.notifier).dates(s_time);
                                      print(s_time.toString());
                                      print(notifications.toString());
                                      print(DateTime.now().timeZoneName);
                                    }, locale: picker.LocaleType.en);

                              },
                              child: TileWidget(
                                  width: 120,
                                  icon: FontAwesome.clock_o,
                                  text: startTime==''?"Start": startTime.substring(10,16)
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "End Time",
                                style: appStyle(16, AppConst.kLight, FontWeight.w500)),
                            const HeightSpacer(height: 20),
                            GestureDetector(
                              onTap:() async {

                                picker.DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(DateTime.now().year+2),
                                    onConfirm: (e_time) {
                                      ref.read(finishTimeStateProvider.notifier).setFinish(e_time.toString());
                                      print(e_time.toString());
                                    }, locale: picker.LocaleType.en);

                              },
                              child:  TileWidget(
                                  width: 120,
                                  icon: FontAwesome.clock_o,
                                  text: finishTime==''?"End": finishTime.substring(10,16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const HeightSpacer(height: 20),

                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:  Padding(
          padding:  EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child: CustomOutlineBtn(
              onTap: (){
                if(titleController.text.isNotEmpty &&
                descController.text.isNotEmpty&& 
                scheduledDate.isNotEmpty&&
                startTime.isNotEmpty&&
                finishTime.isNotEmpty){
                  Task task = Task(
                    title: titleController.text,
                    description: descController.text,
                    isCompleted: 0,
                    date: scheduledDate.substring(0,10),
                    startTime: startTime.substring(10,16),
                    endTime: finishTime.substring(10,16),
                    remind: 0,
                    repeat: "yes",
                  );
                  notifierHelper.scheduledNotification(
                      notifications[0],
                      notifications[1],
                      notifications[2],
                      notifications[3],
                      task);
                  ref.read(todoStateProvider.notifier).addItem(task);
                  ref.read(dateStateProvider.notifier).setDate("");
                  ref.read(startTimeStateProvider.notifier).setStart("");
                  ref.read(finishTimeStateProvider.notifier).setFinish("");
                  titleController.clear();
                  descController.clear();

                  List<Task> listData =  ref.watch(todoStateProvider);
                  String today = ref.read(todoStateProvider.notifier).getToday();
                  var todayList = listData
                      .where((element) =>
                  element.isCompleted == 0 &&
                      element.date!.contains(today) ).toList();
                  ref.read(countStateProvider.notifier).setCount(todayList.length.toString());

                  print("Added");
                  showTopSnackBar(
                    displayDuration: const Duration(seconds: 1),
                    Overlay.of(context),
                    CustomSnackBar.success(
                      backgroundColor: Colors.green,
                      textStyle: appStyle(16, Colors.white, FontWeight.w500),
                      message:
                      "Task Added Successfully..!",
                    ),
                  );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>const HomePage() ,));
                }else{
                  showTopSnackBar(
                    displayDuration: const Duration(seconds: 1),
                    Overlay.of(context),
                    CustomSnackBar.error(
                      textStyle: appStyle(16, Colors.white, FontWeight.w500),
                      message:
                      "Failed to Add Task...!",
                    ),
                  );
                  print("Failed");
                }
              },
              margin: 0,
              width: AppConst.kWidth,
              borderColor: Colors.transparent,
              backColor:titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty&&
                  scheduledDate.isNotEmpty&&
                  startTime.isNotEmpty&&
                  finishTime.isNotEmpty? Colors.orange: Theme.of(context).disabledColor,
              txtColor: Colors.white,
              text: "Add New Task"),
        ),
      ),
    );

  }
}
