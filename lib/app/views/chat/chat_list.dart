import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pangogest/app/views/chat/chat.dart';

import '../../../controllers/controllers.dart';
import '../../../data/data.dart';
import '../../shared/shared.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.user, required this.controller});

  final UserDataController user;
  final MainController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      itemCount: chatListData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  user: user,
                  controller: controller,
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
          child: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                      alignment: Alignment.center,
                      color: theme.unselectedWidgetColor,
                      imageUrl: chatListData[index].imgUrl,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                          alignment: Alignment.center,
                          width: 65,
                          height: 65,
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
                          width: 65,
                          height: 65,
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
                          width: 65,
                          height: 65,
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
                          // Text(
                          //   chatListData[index].id,
                          //   style: theme.textTheme.bodySmall!.copyWith(
                          //     color: theme.unselectedWidgetColor,
                          //     letterSpacing: 2,
                          //     fontSize: 10,
                          //   ),
                          // ),
                          // const Gap(5),
                          Text(
                            chatListData[index].lastMsg,
                            style: theme.textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
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
                                  style: theme.textTheme.bodySmall!.copyWith(
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
        );
      },
    );
  }
}
