import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.marginTop = 15,
    this.marginBottom = 15,
  });

  final double marginBottom;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Container(
      height: 0.5,
      width: width,
      margin: EdgeInsets.only(
        top: marginTop,
        bottom: marginBottom,
      ),
      color: theme.colorScheme.inverseSurface.withOpacity(0.5),
    );
  }
}
