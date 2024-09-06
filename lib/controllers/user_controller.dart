import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class UserDataController extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  String? _names;
  String? _imgUrl;
  String? _adresseString;
  AdresseModel? _adresse;
  String? _email;
  String? _num;
  String? _passwords;
  String? _keywords;
  bool _isLoggedIn = false;
  bool _isRegister = false;

  String? get names => _names;
  String? get imgUrl => _imgUrl;
  AdresseModel? get adresse => _adresse;
  String? get email => _email;
  String? get num => _num;
  String? get passwords => _passwords;
  String? get keywords => _keywords;
  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;

  Future<void> loadUserData() async {
    final prefs = await _prefs;
    _names = prefs.getString('userNames');
    _imgUrl = prefs.getString('userImgUrl');
    _adresseString = prefs.getString('userAdresse');
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _passwords = prefs.getString('userPasswords');
    _keywords = prefs.getString('userKeywords');
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isRegister = prefs.getBool('isRegister') ?? false;
    _adresse = AdresseModel(
      id: _adresseString!.split(" ")[1],
      ville: _adresseString!.split(" ")[5],
      commune: _adresseString!.split(" ")[4],
      quartier: _adresseString!.split(" ")[3],
      cellule: _adresseString!.split(" ")[2],
      avenue: _adresseString!.split(" ")[0],
      num: _adresseString!.split(" ")[1],
    );
    debugPrint('======================= User $_names succefully loading');
    notifyListeners();
  }

  Future<void> signOutUser() async {
    final prefs = await _prefs;
    prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    debugPrint('======================= User $_names succefully loggedOut');
    notifyListeners();
  }

  bool isRegisterUser = false;

  Future<void> registerUser(OwnerModel owner) async {
    final userAdresse =
        "${owner.adresse.avenue} ${owner.adresse.num} ${owner.adresse.cellule} ${owner.adresse.quartier} ${owner.adresse.commune} ${owner.adresse.ville}";
    isRegisterUser = true;
    final prefs = await _prefs;
    prefs.setString('userNames', owner.names);
    prefs.setString('userImgUrl', owner.imgUrl!);
    prefs.setString('userAdresse', userAdresse);
    prefs.setString('userEmail', owner.email!);
    prefs.setString('userNum', owner.num);
    prefs.setString('userPasswords', owner.passwords);
    prefs.setString('userKeywords', owner.keywords);
    prefs.setBool('isRegister', true);
    _names = owner.names;
    _adresse = AdresseModel(
      id: owner.adresse.num,
      ville: owner.adresse.ville,
      commune: owner.adresse.commune,
      quartier: owner.adresse.quartier,
      cellule: owner.adresse.cellule,
      avenue: owner.adresse.avenue,
      num: owner.adresse.num,
    );
    _imgUrl = owner.imgUrl;
    _email = owner.email;
    _num = owner.num;
    _passwords = owner.passwords;
    _keywords = owner.keywords;
    _isRegister = true;
    debugPrint('======================= User $_names succefully register');
    await loadUserData();
    isRegisterUser = false;
    debugPrint('================== isRegister ? $_isRegister');
    notifyListeners();
  }

  bool isConnecting = false;

  Future<void> connectUser(
    BuildContext context,
    String userKey,
    String userWords,
  ) async {
    isConnecting = true;
    final prefs = await _prefs;
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _passwords = prefs.getString('userPasswords');
    debugPrint("$_email || $_num || $_passwords");
    if ((_email == userKey || _num == userKey) && (_passwords != userWords)) {
      myCustomSnackBar(
        context: context,
        text: "Mots de passe incorrect",
      );
    } else if ((_email != userKey && _num != userKey) &&
        (_passwords == userWords)) {
      myCustomSnackBar(
        context: context,
        text: "Email/N° Tél incorrect",
      );
    } else if ((_email == userKey || _num == userKey) &&
        (_passwords == userWords)) {
      prefs.setBool('isLoggedIn', true);
      _isLoggedIn = true;
      Navigator.pop(context);
    } else {
      myCustomSnackBar(
        context: context,
        text: "Informations incorrectes",
      );
    }
    isConnecting = false;
    notifyListeners();
  }

  bool isConnected = false;

  Future<void> checkConnection(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
    notifyListeners();
  }
}
