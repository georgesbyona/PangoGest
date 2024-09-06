class TenantModel {
  final String id;
  final String names;
  final String imgUrl;
  final String maisonID;
  final String? email;
  final String num;
  final String passwords;
  final String keywords;
  final String userType;

  TenantModel({
    required this.id,
    required this.names,
    required this.num,
    required this.passwords,
    required this.keywords,
    required this.maisonID,
    this.userType = "locataire",
    this.imgUrl = "https://avatars.githubusercontent.com/u/127692851?v=4",
    this.email,
  });
}
