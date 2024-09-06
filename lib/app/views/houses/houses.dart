import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/house_network_image_view.dart';
import 'widgets/house_description.dart';
import '../../shared/shared.dart';
import '../../../data/data.dart';

class HousesList extends StatelessWidget {
  const HousesList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Tes maisons")),
      body: SafeArea(
        child: houses.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(AppIcons.houses),
                  Text(
                    "Aucune maison retrouvée",
                    style: GoogleFonts.indieFlower(height: 3),
                    textAlign: TextAlign.center,
                  ),
                  Gap(height * 0.1),
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (houses[index].photo.isNotEmpty) ...{
                              HouseNetworkImageView(index: index),
                            } else ...{
                              Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 120,
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  color: theme.unselectedWidgetColor,
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                    image: AssetImage(AppImages.bckground),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            },
                            HouseDescription(index: index),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {},
      ),
    );
  }
}
