import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller_binder.dart';
import 'package:project/ui/screens/main__bottom_nav_bar_screen.dart';
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
