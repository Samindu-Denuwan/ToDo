import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/common/widgets/width_spacer.dart';
import 'package:todo/features/onBoarding/widgets/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children:  [
              PageOne(),
              PageTwo(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      pageController.nextPage(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.ease);
                    },
                    child: Row(
                      children: [
                        Icon(Ionicons.chevron_forward_circle,
                          size: 30.sp,color: AppConst.kLight,),
                        WidthSpacer(width: 5),
                        ReusableText(
                            text: "Skip",
                            style: appStyle(16,
                                AppConst.kLight,
                                FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      pageController.nextPage(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.ease);
                    },
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: WormEffect(
                          dotHeight: 12.h,
                          dotWidth: 16.w,
                          spacing: 10.w,
                          dotColor: AppConst.kYellow
                      ),

                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
