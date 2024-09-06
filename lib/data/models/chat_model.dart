class ChatModel {
  final String id;
  final String name;
  final String imgUrl;
  final String lastMsg;
  final int? lastMsgTotal;
  final String lastMsgTime;
  final bool isRead;

  ChatModel({
    required this.id,
    required this.name,
    this.imgUrl = "https://uxwing.com/man-user-circle-black-icon",
    required this.lastMsg,
    this.lastMsgTotal = 1,
    required this.lastMsgTime,
    required this.isRead,
  });
}

List<ChatModel> chatListData = [
  ChatModel(
    id: "+243 994 069 559",
    name: "Johanna MJ",
    lastMsg:
        "Le noir c'est vraiment ''Beau'' !\nLes applications tout blanc et avec beaucoup des couleurs c'est moche, j'aime bien ce que tu as fait ! Ça ne dérange pas mes yeux ! Et j'espère que ça va continuer comme ça",
    lastMsgTime: "6:56 pm",
    lastMsgTotal: 2,
    isRead: false,
  ),
  ChatModel(
    id: "mariereinenyota@gmail.com",
    name: "Marie-Reine B",
    imgUrl: "https://avatars.githubusercontent.com/u/141399363?v=4",
    lastMsg: "🤦‍♂🤦‍♂🤦‍♂🤦‍♂ Oups !",
    lastMsgTime: "11:32 pm",
    lastMsgTotal: 2,
    isRead: false,
  ),
  ChatModel(
    id: "kevinkish112@gmail.com",
    name: "Kevin Kish",
    imgUrl: "https://avatars.githubusercontent.com/u/147336570?v=4",
    lastMsg: "Mais bon c'est quand même bien faut commencer encore à suivre ça",
    lastMsgTime: "2:23 am",
    lastMsgTotal: 5,
    isRead: true,
  ),
  ChatModel(
    id: "+243 994 822 893",
    name: "Toussaint",
    lastMsg:
        "Kk demain on sera à karhale on ne sais pas toi tu seras où pour qu'on puisse se voir",
    lastMsgTime: "5:15 pm",
    lastMsgTotal: 5,
    isRead: false,
  ),
  ChatModel(
    id: "meschacknjuci@gmail.com",
    name: "Meschack Njuci",
    imgUrl: "https://avatars.githubusercontent.com/u/110793230?s=70&v=4",
    lastMsg: "@~moisewillletalisman🕷️ @~Toussaint 🤣🤣🤣🔥🔥🔥",
    lastMsgTime: "7:35 am",
    isRead: true,
  ),
  ChatModel(
    id: "moisewillletalisman@gmail.com",
    name: "Moïse Will",
    lastMsg: "1 point pour toi @G-Losingson23 🧑‍💻",
    lastMsgTime: "6:57 am",
    isRead: true,
  ),
  ChatModel(
    id: "georgesbyona@gmail.com",
    name: "Georges Byona",
    imgUrl: "https://avatars.githubusercontent.com/u/127692851?v=4",
    lastMsg:
        "Ici par exemple nous avons perdu toute la connexion vu notre position à la frontière avec le Rwanda",
    lastMsgTime: "11:45 pm",
    isRead: false,
  ),
];
