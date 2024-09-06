import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared.dart';

DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
  backgroundColor: AppColors.white,
  confirmButtonStyle: ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(AppColors.black),
    textStyle: WidgetStatePropertyAll(GoogleFonts.raleway()),
  ),
  cancelButtonStyle: ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(AppColors.black),
    textStyle: WidgetStatePropertyAll(GoogleFonts.raleway()),
  ),
  dayForegroundColor: const WidgetStatePropertyAll(AppColors.black),
  dayStyle: GoogleFonts.indieFlower(
    color: AppColors.blackO,
  ),
  dividerColor: AppColors.blackO,
  headerForegroundColor: AppColors.black,
  headerHeadlineStyle: GoogleFonts.indieFlower(
    color: AppColors.black,
  ),
  headerHelpStyle: GoogleFonts.indieFlower(
    color: AppColors.black,
  ),
  rangePickerBackgroundColor: AppColors.primary,
  rangePickerHeaderHeadlineStyle: GoogleFonts.indieFlower(
    color: AppColors.black,
  ),
  rangePickerHeaderHelpStyle: GoogleFonts.indieFlower(
    color: AppColors.black,
  ),
  rangeSelectionBackgroundColor: AppColors.yellow,
  rangeSelectionOverlayColor: const WidgetStatePropertyAll(AppColors.greenO),
  rangePickerHeaderForegroundColor: AppColors.black,
  todayForegroundColor: const WidgetStatePropertyAll(AppColors.black),
  todayBorder: const BorderSide(color: AppColors.blackI),
  weekdayStyle: GoogleFonts.indieFlower(
    color: AppColors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.indieFlower(
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    ),
    labelStyle: GoogleFonts.indieFlower(
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    ),
    errorStyle: GoogleFonts.indieFlower(
      fontWeight: FontWeight.normal,
      color: AppColors.red,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.black,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  yearForegroundColor: const WidgetStatePropertyAll(AppColors.black),
  yearStyle: GoogleFonts.indieFlower(color: AppColors.black),
);
