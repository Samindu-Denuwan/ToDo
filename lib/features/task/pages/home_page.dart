import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/xpansion_provider.dart';
import 'package:todo/features/task/pages/add.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';



class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin{
  final TextEditingController searchController = TextEditingController();
  late final TabController tabController = TabController(
      length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      backgroundColor: AppConst.kGreyBk,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(95),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: "Dashboard", style: appStyle(20, Colors.white, FontWeight.w600)),
                    InkWell(
                      borderRadius: BorderRadius.circular(30.sp),
                      splashColor: AppConst.kGreyLight,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTask(),));
                      },
                        child: Icon(Icons.add_circle_rounded, color: Colors.white, size: 30.sp,))
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                  keyboard: TextInputType.text,
                  hint: "Search",
                  height: 60,
                  hintStyle: appStyle(17, Colors.grey.shade500, FontWeight.w400),
                  controller: searchController,
                  style: appStyle(18, Colors.black87, FontWeight.w400),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: (){},
                    child: const Icon(AntDesign.search1,color: AppConst.kGreyLight,),


                  ),
                ),
                suffixIcon: const Icon(FontAwesome.sliders, color: AppConst.kGreyLight,),
              ),
              const HeightSpacer(height: 15),

            ],

          ),),
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: AppConst.kbkDark,
          systemNavigationBarIconBrightness: Brightness.light
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Icon(FontAwesome.tasks, size: 20.sp, color: Colors.white,),
                      WidthSpacer(width: 10.w),
                      ReusableText(text: "Today's Task",
                          style: appStyle(18, Colors.white, FontWeight.w500))
                    ],
                  ),
                  HeightSpacer(height: 20.h),
                  Container(
                    child: TabBar(
                        controller: tabController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        dividerColor: Colors.transparent,
                       indicatorColor: Colors.orange,
                        splashBorderRadius: BorderRadius.circular(8.w),
                        splashFactory: NoSplash.splashFactory,
                        isScrollable: false,

                        labelColor: Colors.white,
                        labelStyle: appStyle(18, Colors.white, FontWeight.w500),
                        unselectedLabelColor: Colors.white.withOpacity(0.4),
                        unselectedLabelStyle:  appStyle(16,  Colors.white.withOpacity(0.4), FontWeight.w400),
                        tabs: [
                          Tab(
                            child: SizedBox(
                              width: AppConst.kWidth*0.5,
                              child: const Center(
                                child: Text(
                                    "Pending"
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.only(left: 30.w),
                              width: AppConst.kWidth*0.5,
                              child: const Center(
                                child: Text(
                                  "Completed"
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),

                  ),
                  const HeightSpacer(height: 25),
                  SizedBox(
                   height: AppConst.kHeight*0.3,
                    width: AppConst.kWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.w),
                      child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              color: Colors.white.withOpacity(0.3),
                              height: AppConst.kHeight*0.3,
                              child: TodayTask(),
                            ),
                            Container(
                              color: Colors.white.withOpacity(0.3),
                              height: AppConst.kHeight*0.3,
                              child: ListView(
                                children: [
                                  TodoTile(
                                    start: "03:00",
                                    end: "05:00",
                                    switcher: Padding(
                                      padding:  EdgeInsets.only(right:12.w ),
                                      child: const Icon(Icons.check_circle, color: Colors.green,),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ]),

                    )
                  ),
                  const HeightSpacer(height: 20),
                  CustomExpansionTile(
                    onExpansionChanged: (bool expanded){
                      ref.read(xpansionStateProvider.notifier).setStart(!expanded);
                    },
                      trailing: Padding(
                            padding:  EdgeInsets.only(right:12.w ),
                            child: ref.watch(xpansionStateProvider)
                                ?const Icon(AntDesign.circledown, color: Colors.white,)
                                :const Icon(AntDesign.closecircle, color: Colors.orange,),
                          ),
                      text: "Tomorrow's Task",
                      text2: "Tomorrow's tasks are shown here",
                      children: [
                        TodoTile(
                          start: "03:00",
                          end: "05:00",
                          switcher: Padding(
                            padding:  EdgeInsets.only(right:8.w ),
                            child: const Icon(Icons.check_circle, color: Colors.green,),
                          ),

                        ),
                      ]
                  ),

                  const HeightSpacer(height: 20),
                   CustomExpansionTile(
                      text: DateTime.now().add( const Duration(days: 2)).toString().substring(5,10),
                      text2: "Day after tomorrow's tasks",
                       onExpansionChanged: (bool expanded){
                         ref.read(xpansionState0Provider.notifier).setStart(!expanded);
                       },
                       trailing: Padding(
                         padding:  EdgeInsets.only(right:12.w ),
                         child: ref.watch(xpansionState0Provider)
                             ?const Icon(AntDesign.circledown, color: Colors.white,)
                             :const Icon(AntDesign.closecircle, color: Colors.orange,),
                       ),
                      children: [
                        TodoTile(
                          start: "03:00",
                          end: "05:00",
                          switcher: Padding(
                            padding:  EdgeInsets.only(right:8.w),
                            child: const Icon(Icons.check_circle, color: Colors.green,),
                          ),

                        ),
                      ]
                  ),

                ],
              ),

            ),
          ),
      ),

    );

  }

}

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   List<Task> listData =  ref.watch(todoStateProvider);
   String today = ref.read(todoStateProvider.notifier).getToday();
   var todayList = listData
        .where((element) =>
    element.isCompleted == 0 &&
        element.date!.contains(today) ).toList();
   return ListView.builder(
      itemCount: todayList.length,
        itemBuilder: (context, index) {
        final data = todayList[index];
          return TodoTile(
            title: data.title,
            description: data.description,
            start: data.startTime,
            end: data.endTime,
            color: AppConst.kYellow,
            switcher: Switch(
                activeColor: Colors.white,
                activeTrackColor: Colors.orange,
                inactiveTrackColor: Colors.grey,
                value: true,
                onChanged: (value){}),

          );
        },);
  }
}

// showModalBottomSheet(
// isScrollControlled: true,
// backgroundColor: Colors.transparent,
// context: context, builder: (context) {
// return GestureDetector(
// onTap: ()=>FocusScope.of(context).unfocus(),
// child: Container(
// padding: EdgeInsets.only(bottom: 40.h),
// height: AppConst.kHeight*0.8,
// width: AppConst.kWidth,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.only(
// topLeft:
// Radius.circular(30.w),
// topRight:
// Radius.circular(30.w),
// ),
// color: AppConst.kLight),
// child: Column(
// children: [
// Padding(
// padding:  EdgeInsets.symmetric(vertical: 10.h),
// child: Container(
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius
//     .circular(10
//     .w),
// color: Colors.grey.shade400),
// width: 70.w,
// height: 8.h,
// ),
// ),
// Expanded(
// child: Padding(
// padding:  EdgeInsets.symmetric(horizontal: 20.w),
// child: ListView(
// children: [
// Center(
// child: ReusableText(text: "New Task",
// style: appStyle(18, AppConst.kbkDark, FontWeight.w500)),
// ),
// const HeightSpacer(height: 10),
// ReusableText(text: "Title",
// style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
// const HeightSpacer(height: 10),
// CustomTextField(
// boxShadow: true,
// height: 65,
// keyboard: TextInputType.text,
// hint:"Add Title", controller: titleController,
// hintStyle: appStyle(16, Colors.grey.shade500, FontWeight.w400),
// style: appStyle(18, AppConst.kGreyLight, FontWeight.w600)),
//
// const HeightSpacer(height: 20),
// ReusableText(text: "Description",
// style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
// const HeightSpacer(height: 10),
// CustomTextField(
// boxShadow: true,
// height: 150,
// maxLine: 6,
// keyboard: TextInputType.text,
// hint:"Add Description", controller: descController,
// hintStyle: appStyle(14, Colors.grey.shade500, FontWeight.w400),
// style: appStyle(16, AppConst.kGreyLight, FontWeight.w500)),
// const HeightSpacer(height: 30),
// GestureDetector(
// onTap:(){
// picker.DatePicker.showDatePicker(context,
// showTitleActions: true,
// minTime: DateTime(2023, 6, 25),
// maxTime: DateTime(2024, 6, 7),
// theme: const picker.DatePickerTheme(
// doneStyle:
// TextStyle(color: Colors.orange, fontSize: 16)),
// onConfirm: (date) {
// ref.read(dateStateProvider.notifier).setDate(date.toString());
// }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
// },
// child: TileWidget(
// width: AppConst.kWidth,
// icon: FontAwesome.calendar,
// text: "Set Date"),
// ),
// const HeightSpacer(height: 20),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// GestureDetector(
// onTap:(){},
// child: const TileWidget(
// width: 150,
// icon: FontAwesome.clock_o,
// text: "Start Time"),
// ),
// const HeightSpacer(height: 20),
// GestureDetector(
// onTap:(){},
// child: const TileWidget(
// width: 150,
// icon: FontAwesome.clock_o,
// text: "End Time"),
// ),
// ],
// ),
//
// ],
// ),
// ),
// ),
// CustomOutlineBtn(
// onTap: (){},
// margin: 20,
// width: AppConst.kWidth,
// borderColor: Colors.orange,
// backColor: Colors.orange,
// txtColor: Colors.white,
// text: "Add New Task"),
//
// ],
// ),
// ),
// );
// },);


