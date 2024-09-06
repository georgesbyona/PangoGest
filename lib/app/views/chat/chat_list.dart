import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
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
  bool isEmpty = true;
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
    final height = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      body: isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(AppIcons.addMessage),
                Text(
                  "Pas de discussions",
                  style: GoogleFonts.indieFlower(height: 3),
                  textAlign: TextAlign.center,
                ),
                Gap(height * 0.1),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              itemCount: chatListData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          user: widget.user,
                          controller: widget.controller,
                          otherU: ChatModel(
                            id: chatListData[index].id,
                            name: chatListData[index].name,
                            imgUrl: chatListData[index].imgUrl,
                            lastMsg: chatListData[index].lastMsg,
                            lastMsgTime: chatListData[index].lastMsgTime,
                            lastMsgTotal: chatListData[index].lastMsgTotal,
                            isRead: chatListData[index].isRead,
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
                                imageUrl: chatListData[index].imgUrl,
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
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(chatListData[index].name),
                                    Text(
                                      chatListData[index].lastMsg,
                                      style: theme.textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Column(
                                children: [
                                  Text(
                                    chatListData[index].lastMsgTime,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      color: theme.unselectedWidgetColor,
                                      fontWeight: FontWeight.bold,
                                      height: 2,
                                    ),
                                  ),
                                  chatListData[index].isRead
                                      ? const Gap(18)
                                      : Container(
                                          alignment: Alignment.center,
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            "${chatListData[index].lastMsgTotal}",
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
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
            ),
      floatingActionButton: _isAtTop || isEmpty
          ? CustomFAB(
              onPressed: () {
                setState(() {
                  isEmpty = !isEmpty;
                });
              },
              icon: AppIcons.addMessage,
            )
          : CustomFABMini(
              onPressed: () {
                setState(() {
                  isEmpty = !isEmpty;
                });
              },
              icon: AppIcons.addMessage,
            ),
    );
  }
}
