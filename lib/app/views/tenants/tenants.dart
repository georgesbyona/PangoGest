import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/controllers.dart';
import 'pages/new_tenant/add_new_tenant.dart';
import '../../shared/shared.dart';
import 'widgets/tenant_descriptions.dart';
import 'widgets/tenant_network_image_view.dart';

class TenantsList extends StatelessWidget {
  const TenantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final users = Provider.of<UserDataController>(context);
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Tes locataires")),
      body: SafeArea(
        child: users.usersList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(AppIcons.tenants),
                  Text(
                    "Aucun locataire retrouvé",
                    style: GoogleFonts.raleway(height: 3),
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
                itemCount: users.usersList.length,
                itemBuilder: (context, index) {
                  final tenants = users.usersList;
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
                            if (tenants[index].imgUrl!.isNotEmpty) ...{
                              TenantNetworkImageView(
                                index: index,
                                tenants: tenants,
                              ),
                            } else ...{
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: theme.unselectedWidgetColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  AppIcons.profileB,
                                  color: theme.primaryColorDark,
                                  size: 35,
                                ),
                              ),
                            },
                            TenantDescriptions(
                              tenants: tenants,
                              index: index,
                            ),
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
          // controller.readHouses();
          controller.currentHouse = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTenantPage(controller: controller),
            ),
          );
        },
        icon: AppIcons.addUser,
      ),
    );
  }
}
