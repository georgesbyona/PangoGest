import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

Widget customDialogView(
  context, {
  String? title,
  String? hintText,
  onTap,
  onChanged,
}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  final sizeWidth = width > height ? height : width;
  final theme = Theme.of(context);
  return SimpleDialog(
    alignment: Alignment.center,
    backgroundColor: theme.highlightColor,
    children: [
      Container(
        padding: EdgeInsets.all(sizeWidth * 0.04),
        child: Column(
          children: [
            Text("$title"),
            TextFormField(
              style: theme.textTheme.bodySmall!
                  .copyWith(fontSize: sizeWidth * 0.03),
              cursorColor: theme.colorScheme.inverseSurface,
              cursorWidth: 1,
              maxLines: null,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "$hintText",
                hintStyle: theme.textTheme.bodySmall!.copyWith(
                  fontSize: sizeWidth * 0.025,
                  color: theme.unselectedWidgetColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.primaryColorDark,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.inverseSurface,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            Gap(width * 0.02),
            bottomDialogButtonView(
              context,
              onTap: onTap,
              confirmText: 'Envoyer',
            ),
          ],
        ),
      ),
    ],
  );
}

Row bottomDialogButtonView(context, {isCenter = false, onTap, confirmText}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  final sizeWidth = width > height ? height : width;
  final theme = Theme.of(context);
  return Row(
    mainAxisAlignment:
        isCenter ? MainAxisAlignment.center : MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: sizeWidth * 0.025,
            vertical: sizeWidth * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'Annuler',
            style: TextStyle(fontSize: sizeWidth * 0.025),
          ),
        ),
      ),
      Gap(width * 0.02),
      GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: sizeWidth * 0.025,
            vertical: sizeWidth * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.inverseSurface,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            confirmText ?? "Envoyer",
            style: TextStyle(fontSize: sizeWidth * 0.025),
          ),
        ),
      ),
    ],
  );
}
