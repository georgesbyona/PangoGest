class ProprioModel {
  final String names;
  final String? imgUrl;
  final String adresse;
  final String? email;
  final String num;
  final String passwords;
  final String keywords;

  ProprioModel({
    this.email,
    this.imgUrl,
    required this.names,
    required this.adresse,
    required this.num,
    required this.passwords,
    required this.keywords,
  });
}
