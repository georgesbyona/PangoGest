import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class UserDataController extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  String? _names;
  String? _imgUrl;
  String? _adresse;
  String? _email;
  String? _num;
  String? _passwords;
  String? _keywords;
  bool _isLoggedIn = false;
  bool _isRegister = false;

  String? get names => _names;
  String? get imgUrl => _imgUrl;
  String? get adresse => _adresse;
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
    _adresse = prefs.getString('userAdresse');
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _passwords = prefs.getString('userPasswords');
    _keywords = prefs.getString('userKeywords');
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isRegister = prefs.getBool('isRegister') ?? false;
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

  Future<void> registerUser(ProprioModel proprio) async {
    isRegisterUser = true;
    final prefs = await _prefs;
    prefs.setString('userNames', proprio.names);
    prefs.setString('userImgUrl', proprio.imgUrl!);
    prefs.setString('userAdresse', proprio.adresse);
    prefs.setString('userEmail', proprio.email!);
    prefs.setString('userNum', proprio.num);
    prefs.setString('userPasswords', proprio.passwords);
    prefs.setString('userKeywords', proprio.keywords);
    prefs.setBool('isRegister', true);
    _names = proprio.names;
    _adresse = proprio.adresse;
    _imgUrl = proprio.imgUrl;
    _email = proprio.email;
    _num = proprio.num;
    _passwords = proprio.passwords;
    _keywords = proprio.keywords;
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
