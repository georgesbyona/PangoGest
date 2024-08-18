import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

Widget customDialogView(
  context, {
  String? title,
  String? hintText,
  onTap,
  onChanged,
}) {
  final theme = Theme.of(context);
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  return SimpleDialog(
    alignment: Alignment.center,
    backgroundColor: theme.highlightColor,
    children: [
      Container(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          children: [
            Text("$title"),
            TextFormField(
              style:
                  theme.textTheme.bodySmall!.copyWith(fontSize: width * 0.03),
              cursorColor: theme.colorScheme.inverseSurface,
              cursorWidth: 1,
              maxLines: null,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "$hintText",
                hintStyle: theme.textTheme.bodySmall!.copyWith(
                  fontSize: width * 0.025,
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
            Gap(height * 0.02),
            bottomDialogButtonView(
              context: context,
              onTap: onTap,
              confirmText: 'Envoyer',
            ),
          ],
        ),
      ),
    ],
  );
}

Row bottomDialogButtonView({context, onTap, confirmText}) {
  final width = MediaQuery.sizeOf(context).width;
  final theme = Theme.of(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.025,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'Annuler',
            style: TextStyle(fontSize: width * 0.025),
          ),
        ),
      ),
      Gap(width * 0.02),
      GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
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
            '$confirmText',
            style: TextStyle(fontSize: width * 0.025),
          ),
        ),
      ),
    ],
  );
}
