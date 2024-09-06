import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/shared.dart';

class TenantsList extends StatelessWidget {
  const TenantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: const Text("Tes locataires")),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(AppIcons.tenants),
            Text(
              "Aucun locataire retrouvé",
              style: GoogleFonts.indieFlower(height: 3),
              textAlign: TextAlign.center,
            ),
            Gap(height * 0.1),
          ],
        ),
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {},
        icon: AppIcons.addUser,
      ),
    );
  }
}
