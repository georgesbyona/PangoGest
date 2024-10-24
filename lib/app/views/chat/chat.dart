import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/controllers.dart';
import 'widgets/chat_widgets.dart';
import '../../shared/shared.dart';
import '../../../data/data.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.user,
    required this.controller,
    required this.otherU,
    this.fromTenant = false,
  });

  final UserDataController user;
  final MainController controller;
  final ChatModel otherU;
  final bool fromTenant;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController? _chatController;
  bool cancelReply = false;
  double imageWidth = 200;
  final List<Message> userChats = [];

  // List<Message> messages = widget.otherU.messages;
  //  [
  // Message(
  //   id: "7",
  //   message: "Bien reçu G !",
  //   createdAt: DateTime.now(),
  //   sentBy: "glosingson@gmail.com",
  //   replyMessage: const ReplyMessage(
  //     messageId: "4",
  //     message: "https://pub.dev/packages/chatview",
  //     replyBy: "glosingson@gmail.com",
  //     replyTo: "georgesbyona@gmail.com",
  //   ),
  // ),
  // ];

  @override
  void initState() {
    final userID = widget.user.email ?? widget.user.num;
    for (var msg in widget.otherU.messages) {
      userChats.add(msg);
    }
    _chatController = ChatController(
      initialMessageList: userChats,
      scrollController: ScrollController(),
      currentUser: ChatUser(
        id: userID!,
        name: widget.user.names!,
        imageType: ImageType.network,
        profilePhoto: widget.user.imgUrl,
      ),
      otherUsers: [
        ChatUser(
          id: widget.otherU.email,
          name: widget.otherU.names,
          imageType: ImageType.network,
          profilePhoto: widget.otherU.imgUrl,
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    customSystemChrome(widget.controller);
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);

    return Scaffold(
      body: ChatView(
        chatController: _chatController!,
        onSendTap: _onSendTap,
        featureActiveConfig: const FeatureActiveConfig(
          enableReactionPopup: true,
          enableOtherUserName: false,
          enableCurrentUserProfileAvatar: false,
        ),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          errorWidgetConfig: const ChatViewStateWidgetConfiguration(),
          noMessageWidgetConfig: const ChatViewStateWidgetConfiguration(
            widget: Icon(Icons.hourglass_empty_rounded),
          ),
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.primaryColor,
            widget: const CircularProgressIndicator(strokeWidth: 2),
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          indicatorSize: 5,
          indicatorSpacing: 1,
          flashingCircleBrightColor: theme.primaryColorDark,
          flashingCircleDarkColor: theme.colorScheme.inverseSurface,
        ),
        appBar: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: chatAppBar(
            context,
            theme: theme,
            controller: widget.controller,
            chatController: _chatController,
          ),
        ),
        chatBackgroundConfig: chatBckConfig(theme),
        sendMessageConfig: SendMessageConfiguration(
          allowRecordingVoice: false,
          enableCameraImagePicker: false,
          enableGalleryImagePicker: false,
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraImagePickerIcon: Icon(
              AppIcons.camera,
              color: theme.primaryColor,
            ),
            galleryImagePickerIcon: Icon(
              AppIcons.gallery,
              color: theme.primaryColor,
            ),
          ),
          sendButtonIcon: Icon(
            AppIcons.send,
            color: theme.primaryColor,
          ),
          replyTitleColor: theme.primaryColor,
          replyMessageColor: theme.primaryColor,
          replyDialogColor: theme.unselectedWidgetColor.withOpacity(0.5),
          textFieldBackgroundColor: theme.highlightColor,
          closeIconColor: theme.colorScheme.inversePrimary,
          textFieldConfig: textFieldConfig(theme),
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          maxWidth: width * 0.7,
          outgoingChatBubbleConfig: rightChatBubble(theme),
          inComingChatBubbleConfig: leftChatBubble(theme),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
          replyPopupBuilder: (message, sentByCurrentUser) {
            return Container();
          },
          backgroundColor: theme.scaffoldBackgroundColor,
          buttonTextStyle: GoogleFonts.poiretOne(),
          topBorderColor: Colors.transparent,
        ),

        emojiPickerSheetConfig: Config(
          height: 10,
          categoryViewConfig: CategoryViewConfig(
            customCategoryView: (config, state, tabController, pageController) {
              return Container();
            },
            backgroundColor: Colors.greenAccent,
          ),
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: theme.highlightColor,
          ),
        ),
        // Pour la configuration du TextField
        // sendMessageBuilder: (replyMessage) {
        //   return Container();
        // },
        replyMessageBuilder: (context, replyMessage) {
          customSystemChrome(widget.controller);
          final replyTo = replyMessage.replyTo == widget.user.email
              ? "toi-même"
              : _chatController!.otherUsers.first.name.split(' ')[0];
          return cancelReply
              ? const Icon(null)
              : replyView(
                  theme: theme,
                  width: width,
                  replyTo: replyTo,
                  replyMessage: replyMessage,
                  onTap: cancelReplyView,
                );
        },
        loadingWidget: const LinearProgressIndicator(minHeight: 2),

        messageConfig: MessageConfiguration(
          customMessageBuilder: (message) {
            return Container();
          },
          customMessageReplyViewBuilder: (replyMessage) {
            return Container();
          },
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: AppColors.white.withOpacity(0.5),
            borderColor: theme.primaryColor.withOpacity(0.5),
            reactedUserCountTextStyle: GoogleFonts.poiretOne(
              color: theme.colorScheme.inversePrimary,
              fontSize: 10,
            ),
            reactionCountTextStyle: GoogleFonts.poiretOne(
              color: theme.colorScheme.inversePrimary,
              fontSize: 10,
            ),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.scaffoldBackgroundColor,
              reactionWidgetPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              reactedUserTextStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.highlightColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            hideShareIcon: true,
            width: width * 0.7,
            borderRadius: BorderRadius.circular(10),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
        ),
        profileCircleConfig: profileConfig(theme, _chatController!),
        repliedMessageConfig: repliedMsgConfig(
          theme: theme,
          width: width,
          user: widget.user,
          chatController: _chatController,
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          onLeftSwipe: (message, sentBy) => enableReplyView(),
          onRightSwipe: (message, sentBy) => enableReplyView(),
          replyIconColor: theme.primaryColor,
          replyIconBackgroundColor: theme.scaffoldBackgroundColor,
          replyIconProgressRingColor: theme.primaryColor.withOpacity(0.5),
        ),
        replySuggestionsConfig: ReplySuggestionsConfig(
          itemConfig: SuggestionItemConfig(
            decoration: BoxDecoration(
              color: theme.unselectedWidgetColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.inversePrimary),
            ),
            textStyle: const TextStyle(
              letterSpacing: 1,
              fontSize: 12,
            ),
          ),
          onTap: (SuggestionItemData suggestionItems) {
            _onSendTap(
              suggestionItems.text,
              const ReplyMessage(),
              MessageType.text,
            );
          },
        ),
      ),
    );
  }

  void cancelReplyView() {
    setState(() {
      cancelReply = true;
    });
  }

  void enableReplyView() {
    setState(() {
      cancelReply = false;
    });
  }

  void showHideTypingIndicator() {
    _chatController!.setTypingIndicator = !_chatController!.showTypingIndicator;
  }

  void receiveMessage() async {
    _chatController!.addMessage(
      Message(
        id: DateTime.now().toString(),
        message: 'I will schedule the meeting.',
        createdAt: DateTime.now(),
        sentBy: '2',
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _chatController!.addReplySuggestions([
      const SuggestionItemData(text: 'Thanks.'),
      const SuggestionItemData(text: 'Thank you very much.'),
      const SuggestionItemData(text: 'Great.')
    ]);
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    _chatController!.addMessage(
      Message(
        id: DateTime.now().toString(),
        createdAt: DateTime.now(),
        message: message,
        sentBy: _chatController!.currentUser.id,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    if (widget.fromTenant) {
      await ChatDBServices.addMessage(
        _chatController!.otherUsers.first.id,
        _chatController!.currentUser.id,
        [
          {
            "id": DateTime.now().toString(),
            "message": message,
            "sentBy": _chatController!.currentUser.id,
            "sentTo": _chatController!.otherUsers.first.id,
          },
        ],
      );
    } else {
      await ChatDBServices.addMessage(
        _chatController!.currentUser.id,
        _chatController!.otherUsers.first.id,
        [
          {
            "id": DateTime.now().toString(),
            "message": message,
            "sentBy": _chatController!.currentUser.id,
            "sentTo": _chatController!.otherUsers.first.id,
          },
        ],
      );
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      _chatController!.initialMessageList.last.setStatus =
          MessageStatus.undelivered;
    });
    Future.delayed(const Duration(seconds: 1), () {
      _chatController!.initialMessageList.last.setStatus = MessageStatus.read;
    });
  }
}
