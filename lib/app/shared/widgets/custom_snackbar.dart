import 'dart:async';

import 'package:flutter/material.dart';

import '../shared.dart';

void myCustomSnackBar({
  context,
  text,
  Color? backgroundColor,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    canSizeOverlay: true,
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: mySnackBar(context, text, backgroundColor),
    ),
  );
  overlay.insert(overlayEntry);

  Timer(const Duration(milliseconds: 2500), () {
    overlayEntry.remove();
  });
}

Widget mySnackBar(BuildContext context, String text, Color? backgroundColor) {
  final bckColor = backgroundColor ?? Theme.of(context).primaryColorDark;
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: width * 0.015,
      horizontal: width * 0.025,
    ),
    margin: EdgeInsets.only(bottom: height * 0.085),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: bckColor,
    ),
    child: SizedBox(
      height: width * 0.065,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0.0,
            child: SizedBox(
              height: width * 0.06,
              width: width * 0.06,
              child: Image.asset(AppImages.logo),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.07),
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
