import 'package:chatview/chatview.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pangogest/app/views/chat/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import '../../../data/data.dart';
import '../../shared/shared.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key, required this.user, required this.controller});

  final UserDataController user;
  final MainController controller;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ScrollController scrollController = ScrollController();
  bool _isAtTop = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == 0) {
        setState(() {
          _isAtTop = true;
        });
      } else {
        setState(() {
          _isAtTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataController>(context);
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: ChatDBServices.getTenants(user.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(AppIcons.addMessage),
                const Text(
                  "Pas de discussions",
                  style: TextStyle(height: 3),
                  textAlign: TextAlign.center,
                ),
                Gap(height * 0.1),
              ],
            );
          } else {
            List<ChatModel> datas = [];
            List<Message> userMsgs = [];
            for (var d in snapshot.data!.docs) {
              final data = d.data();
              final chat = ChatModel.fromJson(data);
              datas.add(chat);
              for (var msg in chat.messages) {
                userMsgs.add(msg!);
              }
            }
            if (datas.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(AppIcons.addMessage),
                  const Text(
                    "Pas de discussions",
                    style: TextStyle(height: 3),
                    textAlign: TextAlign.center,
                  ),
                  Gap(height * 0.1),
                ],
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final firstLetter =
                    datas[index].names.split(" ")[0].substring(0, 1);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          user: widget.user,
                          controller: widget.controller,
                          otherU: ChatModel(
                            email: datas[index].email,
                            names: datas[index].names,
                            imgUrl: datas[index].imgUrl,
                            messages: userMsgs,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                alignment: Alignment.center,
                                color: theme.unselectedWidgetColor,
                                imageUrl: datas[index].imgUrl!,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 70,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: theme.unselectedWidgetColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      AppIcons.profileB,
                                      color: theme.primaryColorDark,
                                      size: 30,
                                    ),
                                  );
                                },
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 70,
                                    height: 70,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: theme.unselectedWidgetColor,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 70,
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                      color: theme.unselectedWidgetColor,
                                      border: Border.all(
                                        color: theme.highlightColor,
                                        width: 3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      firstLetter,
                                      style: GoogleFonts.specialElite(
                                        color: theme.highlightColor,
                                        fontSize: 30,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(datas[index].names),
                                    const Gap(3),
                                    // Text(
                                    //   datas[index].messages[index].id,
                                    //   style: theme.textTheme.bodySmall,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 3,
                                    // ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Column(
                                children: [
                                  // Text(
                                  //   datas[index].lastMsgTime,
                                  //   style: TextStyle(
                                  //     color: theme.unselectedWidgetColor,
                                  //     fontSize: 11,
                                  //     height: 2,
                                  //   ),
                                  // ),
                                  // datas[index].isRead
                                  //     ? const Gap(18)
                                  //     : Container(
                                  //         alignment: Alignment.center,
                                  //         width: 18,
                                  //         height: 18,
                                  //         decoration: BoxDecoration(
                                  //           color: theme.primaryColor,
                                  //           shape: BoxShape.circle,
                                  //         ),
                                  //         child: Text(
                                  //           "${datas[index].lastMsgTotal}",
                                  //           style: const TextStyle(
                                  //             color: AppColors.white,
                                  //             fontSize: 11,
                                  //           ),
                                  //         ),
                                  //       ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: _isAtTop
          ? CustomFAB(
              onPressed: () {},
              icon: AppIcons.addMessage,
            )
          : CustomFABMini(
              onPressed: () {
                setState(() {});
              },
              icon: AppIcons.addMessage,
            ),
    );
  }
}
