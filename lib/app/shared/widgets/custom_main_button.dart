import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class CustomMainButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  const CustomMainButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width * 0.7,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        margin: EdgeInsets.symmetric(vertical: height * 0.015),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color ?? Colors.transparent),
        ),
        child: Text(
          text,
          style: GoogleFonts.poiretOne(
            color: color ?? AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomMainButton2 extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  const CustomMainButton2({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width * 0.4,
        height: height * 0.15,
        margin: EdgeInsets.symmetric(horizontal: height * 0.015),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color ?? Colors.transparent),
        ),
        child: Text(
          text,
          style: GoogleFonts.poiretOne(
            color: color ?? AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
