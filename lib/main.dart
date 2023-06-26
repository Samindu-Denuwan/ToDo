import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/common/models/user_model.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/auth/controllers/user_controller.dart';
import 'package:todo/features/onBoarding/pages/onBoarding_page.dart';
import 'package:todo/features/task/pages/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/features/task/pages/view_notification.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch:Colors.orange );
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch:Colors.orange );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'CheckMate',
              darkTheme: ThemeData(
                  fontFamily: 'Poppins',
                  useMaterial3: true,
                  scaffoldBackgroundColor: AppConst.kbkDark,
                colorScheme: darkColorScheme?? defaultLightColorScheme
              ),
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: lightColorScheme?? defaultDarkColorScheme,
                scaffoldBackgroundColor: AppConst.kGreyBk,
                useMaterial3: true,
              ),
              home: NotificationsPage()
              //home:users.isEmpty? const OnBoardingPage(): const HomePage(),
            //  onGenerateRoute: Routes.onGenerateRoute,
            );
          }
        );
      }
    );
  }
}


