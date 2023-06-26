import 'package:flutter/material.dart';
import 'package:todo/features/auth/pages/login_page.dart';
import 'package:todo/features/auth/pages/otp_page.dart';
import 'package:todo/features/onBoarding/pages/onBoarding_page.dart';
import 'package:todo/features/task/pages/home_page.dart';

class Routes{
  static const String onBoarding = 'onBoarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
      switch(settings.name){
        case onBoarding:
          return MaterialPageRoute(builder: (context) => const OnBoardingPage(),);
        case login:
          return MaterialPageRoute(builder: (context) => const LoginPage(),);
        case otp:
          final Map args = settings.arguments as Map;
          return MaterialPageRoute(builder: (context) => OtpPage(smsCodeId: args['smsCodeId'], phone: args['phone'],),);

        case home:
          return MaterialPageRoute(builder: (context) => const HomePage(),);

        default:
          return MaterialPageRoute(builder: (context) => const HomePage(),);
      }


  }
}