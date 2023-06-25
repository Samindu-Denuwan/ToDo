import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/xpansion_provider.dart';
import 'package:todo/features/task/pages/add.dart';
import 'package:todo/features/task/widgets/completed_task.dart';
import 'package:todo/features/task/widgets/day_after_tom_tasks.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';
import 'package:todo/features/task/widgets/today_task.dart';
import 'package:todo/features/task/widgets/tomorrow_task.dart';
import 'package:todo/generated/assets.dart';



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
          systemNavigationBarColor: AppConst.kGreyBk,
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
                              child: const TodayTask(),
                            ),
                            Container(
                              color: Colors.white.withOpacity(0.3),
                              height: AppConst.kHeight*0.3,
                              child: const CompletedTask(),
                            ),
                          ]),

                    )
                  ),
                  const HeightSpacer(height: 20),
                  const TomorrowTask(),

                  const HeightSpacer(height: 20),
                   const DayAfterTomorrowTask(),
                  const HeightSpacer(height: 20),


                ],
              ),

            ),
          ),
      ),

    );

  }

}






