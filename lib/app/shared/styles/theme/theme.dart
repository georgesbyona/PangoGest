import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

import 'txttheme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.whiteB,
      onPrimary: AppColors.whiteO,
      secondary: AppColors.whiteI,
      onSecondary: AppColors.whiteB,
      error: AppColors.red.withOpacity(0.8),
      onError: AppColors.red,
      surface: AppColors.whiteOver,
      onSurface: AppColors.whiteB,
      inversePrimary: AppColors.black,
      inverseSurface: AppColors.blackO,
      onInverseSurface: AppColors.blackI,
    ),
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.whiteO,
    primaryColorLight: AppColors.whiteI,
    highlightColor: AppColors.white,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearMinHeight: 1,
      circularTrackColor: AppColors.whiteO,
      linearTrackColor: AppColors.whiteO,
    ),
    scaffoldBackgroundColor: AppColors.whiteB,
    unselectedWidgetColor: Colors.grey.shade700,
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: AppColors.black),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      foregroundColor: AppColors.black,
      titleTextStyle: GoogleFonts.raleway(
        fontWeight: FontWeight.normal,
        color: AppColors.black,
        letterSpacing: 1,
        fontSize: 20,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    textTheme: TxtTheme.lighttxtTheme,
    // textTheme: ThemeData.light().textTheme.apply(
    //       bodyColor: AppColors.black,
    //       displayColor: AppColors.black,
    //     ),
    cardColor: AppColors.whiteOver,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.whiteOver,
      enableFeedback: false,
      focusColor: AppColors.whiteO,
      foregroundColor: AppColors.black,
      hoverColor: AppColors.blackO,
      splashColor: AppColors.whiteO,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.blackB,
      onPrimary: AppColors.blackO,
      secondary: AppColors.blackI,
      onSecondary: AppColors.blackB,
      error: AppColors.red.withOpacity(0.8),
      onError: AppColors.red,
      surface: AppColors.blackOver,
      onSurface: AppColors.blackB,
      inversePrimary: AppColors.white,
      inverseSurface: AppColors.whiteO,
      onInverseSurface: AppColors.whiteI,
    ),
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.blackO,
    primaryColorLight: AppColors.blackI,
    highlightColor: AppColors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearMinHeight: 1,
      color: AppColors.primary,
      circularTrackColor: AppColors.blackO,
      linearTrackColor: AppColors.blackO,
    ),
    scaffoldBackgroundColor: AppColors.blackB,
    unselectedWidgetColor: Colors.grey.shade400,
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      foregroundColor: AppColors.white,
      titleTextStyle: GoogleFonts.raleway(
        fontWeight: FontWeight.normal,
        color: AppColors.white,
        letterSpacing: 1,
        fontSize: 20,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    textTheme: TxtTheme.darktxtTheme,
    // textTheme: ThemeData.light().textTheme.apply(
    //       bodyColor: AppColors.white,
    //       displayColor: AppColors.white,
    //     ),
    cardColor: AppColors.blackOver,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blackOver,
      enableFeedback: false,
      focusColor: AppColors.blackO,
      foregroundColor: AppColors.white,
      hoverColor: AppColors.whiteO,
      splashColor: AppColors.blackO,
    ),
  );
}
