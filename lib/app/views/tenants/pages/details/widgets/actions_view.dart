import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/shared.dart';
import '../../../../../../data/data.dart';

class ActionsView extends StatelessWidget {
  const ActionsView({
    super.key,
    required this.tenants,
    required this.index,
  });

  final List<UserModel> tenants;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    // final user = Provider.of<UserDataController>(context);
    // final controller = Provider.of<MainController>(context);
    final size = width > height ? height : width;
    final List<String> titles = ["Rappel", "Chat", "Supprimer"];
    final List<IconData> icons = [
      AppIcons.remind,
      AppIcons.message,
      AppIcons.delete,
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          titles.length,
          (i) {
            return GestureDetector(
              onTap: () {
                if (i == 1) {
                  // Navigator.push(
                  //   context,
                  // MaterialPageRoute(
                  //   builder: (context) => ChatPage(
                  //     user: user,
                  //     controller: controller,
                  //     otherU: ChatModel(
                  //       email: tenants[index].email,
                  //       name: tenants[index].firstName,
                  //       imgUrl: tenants[index].imgUrl!,
                  //       lastMsgTime: "",
                  //       lastMsg: "",
                  //       isRead: true,
                  //     ),
                  //   ),
                  // ),
                  // );
                }
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: i == 2 ? AppColors.red : theme.highlightColor,
                child: SizedBox(
                  width: size * 0.27,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icons[i], size: 20),
                      const Gap(5),
                      Text(
                        titles[i],
                        style: GoogleFonts.indieFlower(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
