import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.datas,
    required this.hitnText,
    required this.displayValue,
    this.onChanged,
  });

  final String hitnText;
  final String? displayValue;
  final List<String> datas;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: displayValue,
          hint: Text(hitnText, style: theme.textTheme.labelMedium),
          onChanged: onChanged,
          style: theme.textTheme.bodySmall,
          buttonStyleData: ButtonStyleData(
            overlayColor: WidgetStateColor.transparent,
            width: MediaQuery.sizeOf(context).width,
            height: 50,
          ),
          iconStyleData: IconStyleData(
            iconSize: 24,
            iconEnabledColor: theme.colorScheme.inverseSurface,
            iconDisabledColor: Colors.transparent,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            openMenuIcon: const Icon(Icons.arrow_drop_up_rounded),
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 2,
            maxHeight: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
              color: theme.highlightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: WidgetStatePropertyAll(
                theme.primaryColorLight,
              ),
              radius: const Radius.circular(25),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            overlayColor: WidgetStateColor.transparent,
            height: 40,
          ),
          items: datas
              .map(
                (data) => DropdownMenuItem<String>(
                  value: data,
                  child: Text(data),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
