import 'package:ecommerce/controller_binders.dart';
import 'package:ecommerce/presentation/screens/splash_screen.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ECommerce extends StatelessWidget {
  const ECommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce',
      initialBinding: ControllerBinders(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ),
        textTheme: _textTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
        textButtonTheme: _textButtonThemeData(),
      ),
    );
  }

  TextButtonThemeData _textButtonThemeData() {
    return TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
        )
      );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.maxFinite, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
          )
        )
      );
  }

  TextTheme _textTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black54
      ),
      labelSmall: TextStyle(
        color: AppColors.primaryColor,
      )
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      disabledBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey
      )
      );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 2
        )
      );
  }
}
