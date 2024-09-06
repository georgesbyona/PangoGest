import 'package:flutter/material.dart';

Container blurContainer(double width, ThemeData theme) {
  return Container(
    height: 100,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.scaffoldBackgroundColor.withOpacity(0.6),
          theme.scaffoldBackgroundColor.withOpacity(0.3),
          theme.scaffoldBackgroundColor.withOpacity(0.1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}
