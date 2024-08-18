import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

Container blurContainer(double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.black,
          Colors.transparent,
          Colors.transparent,
          AppColors.black,
        ],
        stops: [0.05, 0.5, 0.8, 1.0],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    ),
  );
}
