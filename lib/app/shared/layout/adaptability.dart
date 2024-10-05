import 'package:flutter/material.dart';

class AppAdaptability extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const AppAdaptability({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 904;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 904 &&
        MediaQuery.sizeOf(context).width < 1280;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1280) {
      return desktop;
    } else if (width >= 904 && width < 1280) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
