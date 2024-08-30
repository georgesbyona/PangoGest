import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class BottomBoxesView extends StatelessWidget {
  const BottomBoxesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<IconData> icons = [AppIcons.tenants, AppIcons.houses];
    List<String> labels = ["Locataires", "Maisons"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        icons.length,
        (index) => SizedBox(
          width: 200,
          height: 200,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icons[index], size: 30),
                const Gap(15),
                Text(
                  labels[index],
                  style: theme.textTheme.bodySmall,
                ),
                const Icon(Icons.format_line_spacing_rounded, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
