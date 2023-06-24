import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/todo/controllers/xpansion_provider.dart';
import 'package:todo/features/todo/widgets/tile_todo.dart';

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
    return Scaffold(
      
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
                      onTap: (){},
                        child: Icon(Icons.add_circle_rounded, color: Colors.white, size: 30.sp,))
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                  keyboard: TextInputType.text,
                  hint: "Search",
                  height: 60,
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
                              child: ListView(
                                children: [
                                  TodoTile(
                                    start: "03:00",
                                    end: "05:00",
                                    switcher: Switch(
                                        activeTrackColor: Colors.orange,
                                        inactiveTrackColor: Colors.grey,
                                        value: true,
                                        onChanged: (value){}),

                                  ),
                                ],
                              ),
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


