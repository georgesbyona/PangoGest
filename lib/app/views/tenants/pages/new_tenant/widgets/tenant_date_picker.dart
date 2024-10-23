import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../../../controllers/controllers.dart';
import '../../../../../shared/shared.dart';

class TenantDatePicker extends StatelessWidget {
  const TenantDatePicker({
    super.key,
    required this.onTap,
    required this.controller,
  });

  final MainController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(AppIcons.calendar, size: 24),
                const Gap(20),
                Text(
                  "${controller.contractDate}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Icon(AppIcons.edit, size: 14),
          ],
        ),
      ),
    );
  }
}
