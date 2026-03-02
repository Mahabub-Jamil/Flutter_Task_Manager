import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller_binder.dart';
import 'package:project/ui/screens/add_new_task_screen.dart';
import 'package:project/ui/screens/cancelled_task_screen.dart';
import 'package:project/ui/screens/completed_task_screen.dart';
import 'package:project/ui/screens/forgot_password_email_screen.dart';
import 'package:project/ui/screens/forgot_password_pin_verify_screen.dart';
import 'package:project/ui/screens/forgot_password_set_password_screenn.dart';
import 'package:project/ui/screens/main__bottom_nav_bar_screen.dart';
import 'package:project/ui/screens/new_task_screen.dart';
import 'package:project/ui/screens/profile_screen.dart';
import 'package:project/ui/screens/progress_task_screen.dart';
import 'package:project/ui/screens/sign_in_screen.dart';
import 'package:project/ui/screens/sign_up_screen.dart';
import 'package:project/ui/screens/splash_screen.dart';
import 'package:project/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        MainBottomNavBarScreen.name: (context) =>
            const MainBottomNavBarScreen(),
        SignInScreen.name: (context) => const SignInScreen(),
        SignUpScreen.name: (context) => const SignUpScreen(),
        ProfileScreen.name: (context) => const ProfileScreen(),
        AddNewTaskScreen.name: (context) => const AddNewTaskScreen(),
        NewTaskScreen.name: (context) => const NewTaskScreen(),
        CompletedTaskScreen.name: (context) => const CompletedTaskScreen(),
        CancelledTaskScreen.name: (context) => const CancelledTaskScreen(),
        ProgressTaskScreen.name: (context) => const ProgressTaskScreen(),
        ForgotPasswordEmailScreen.name: (context) =>
            const ForgotPasswordEmailScreen(),
        ForgotPasswordPinVerifyScreen.name: (context) =>
            const ForgotPasswordPinVerifyScreen(),
        ForgotPasswordSetPasswordScreen.name: (context) =>
            const ForgotPasswordSetPasswordScreen(),
      },
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(fontWeight: FontWeight.w300),
      border: _outLineInputBoder(),
      enabledBorder: _outLineInputBoder(),
      errorBorder: _outLineInputBoder(),
      focusedBorder: _outLineInputBoder(),
    );
  }

  OutlineInputBorder _outLineInputBoder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
