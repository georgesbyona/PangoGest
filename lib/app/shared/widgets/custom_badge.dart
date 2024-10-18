import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    this.content,
    required this.icon,
  });

  final IconData icon;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: content == null ? false : true,
      badgeContent: Text(
        content ?? "",
        style: GoogleFonts.raleway(color: AppColors.white, fontSize: 10),
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        curve: Curves.easeOutQuint,
        animationDuration: Duration(milliseconds: 500),
        colorChangeAnimationCurve: Curves.easeOutQuint,
        colorChangeAnimationDuration: Duration(milliseconds: 500),
      ),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.primary,
        padding: EdgeInsets.all(5),
      ),
      child: Icon(icon),
    );
  }
}
