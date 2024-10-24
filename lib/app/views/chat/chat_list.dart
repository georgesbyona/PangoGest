import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pangogest/app/views/chat/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  // bool _isAtTop = true;

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels == 0) {
  //       setState(() {
  //         _isAtTop = true;
  //       });
  //     } else {
  //       setState(() {
  //         _isAtTop = false;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: ChatDBServices.getTenants(widget.user.email!),
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
                Text(
                  "Pas de discussions",
                  style: TextStyle(height: 3),
                  textAlign: TextAlign.center,
                ),
                Gap(height * 0.1),
              ],
            );
          } else {
            List<ChatModel> datas = [];
            List<Message> tenantsMsgs = [];

            for (var d in snapshot.data!.docs) {
              final data = d.data();
              final chat = ChatModel.fromJson(data);
              datas.add(chat);
              for (var chat in chat.messages) {
                final msg = MiMessageModel.fromJson(chat);
                DateTime dateTime = DateTime.parse(msg.id);
                tenantsMsgs.add(
                  Message(
                    id: msg.id,
                    message: msg.message,
                    createdAt: dateTime,
                    sentBy: msg.sentBy,
                  ),
                );
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                            messages: tenantsMsgs,
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
                                    Text(
                                      tenantsMsgs.last.message,
                                      style: theme.textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Column(
                                children: [
                                  if (DateTime.now().day ==
                                      tenantsMsgs.last.createdAt.day) ...{
                                    Text(
                                      DateFormat("HH:mm")
                                          .format(tenantsMsgs.last.createdAt),
                                      style: TextStyle(
                                        color: theme.unselectedWidgetColor,
                                        fontSize: 11,
                                        height: 2,
                                      ),
                                    ),
                                  } else ...{
                                    Text(
                                      DateFormat.E('fr')
                                          .add_Hm()
                                          .format(tenantsMsgs.last.createdAt),
                                      style: TextStyle(
                                        color: theme.unselectedWidgetColor,
                                        fontSize: 11,
                                        height: 2,
                                      ),
                                    ),
                                  }

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
      // floatingActionButton: _isAtTop
      //     ? CustomFAB(
      //         onPressed: () {},
      //         icon: AppIcons.addMessage,
      //       )
      //     : CustomFABMini(
      //         onPressed: () {
      //           setState(() {});
      //         },
      //         icon: AppIcons.addMessage,
      //       ),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.user, required this.controller});

  final UserDataController user;
  final MainController controller;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: widget.user.owner == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: ChatDBServices.getOwner(widget.user.owner!.email),
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
                      Text(
                        "Erreur veuillez vous reconnecter à l'app",
                        style: TextStyle(height: 3),
                        textAlign: TextAlign.center,
                      ),
                      Gap(height * 0.1),
                    ],
                  );
                } else {
                  List<Message> ownerMsgs = [];
                  ChatModel? ownerData;
                  ownerData =
                      ChatModel.fromJson(snapshot.data!.docs.first.data());
                  for (var chat in ownerData.messages) {
                    final msg = MiMessageModel.fromJson(chat);
                    DateTime dateTime = DateTime.parse(msg.id);
                    ownerMsgs.add(
                      Message(
                        id: msg.id,
                        message: msg.message,
                        createdAt: dateTime,
                        sentBy: msg.sentBy,
                      ),
                    );
                  }
                  return ChatPage(
                    fromTenant: true,
                    user: widget.user,
                    controller: widget.controller,
                    otherU: ChatModel(
                      email: ownerData.email,
                      imgUrl: ownerData.imgUrl,
                      names: ownerData.names,
                      messages: ownerMsgs,
                    ),
                  );
                }
              },
            ),
    );
  }
}
