import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import 'widgets/house_network_image_view.dart';
import 'widgets/house_description.dart';
import '../../shared/shared.dart';
import 'pages/add_house.dart';

class HousesList extends StatelessWidget {
  const HousesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Tes maisons")),
      body: SafeArea(
        child: controller.houses.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(AppIcons.houses),
                  Text(
                    "Aucune maison retrouvée",
                    style: TextStyle(height: 3),
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
                itemCount: controller.houses.length,
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
                            if (controller.houses[index].photo.isNotEmpty) ...{
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddHouse(),
            ),
          );
        },
      ),
    );
  }
}
