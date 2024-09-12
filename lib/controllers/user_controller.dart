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
  String? _password;
  String? _userType;
  bool _isLoggedIn = false;
  bool _isRegister = false;

  String? get names => _names;
  String? get imgUrl => _imgUrl;
  AdresseModel? get adresse => _adresse;
  String? get email => _email;
  String? get num => _num;
  String? get password => _password;
  String? get userType => _userType;
  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;

  Future<void> loadUserData() async {
    final prefs = await _prefs;
    _names = prefs.getString('userNames');
    _imgUrl = prefs.getString('userImgUrl');
    _adresseString = prefs.getString('userAdresse');
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _password = prefs.getString('userPassword');
    _userType = prefs.getString('userType');
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isRegister = prefs.getBool('isRegister') ?? false;
    _adresse = AdresseModel(
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

  Future<void> registerUser(UserModel user) async {
    final userAdresse =
        "${user.adresse.avenue} ${user.adresse.num} ${user.adresse.cellule} ${user.adresse.quartier} ${user.adresse.commune} ${user.adresse.ville}";
    isRegisterUser = true;
    final prefs = await _prefs;
    prefs.setString('userNames', user.names);
    prefs.setString('userImgUrl', user.imgUrl!);
    prefs.setString('userAdresse', userAdresse);
    prefs.setString('userEmail', user.email!);
    prefs.setString('userNum', user.num);
    prefs.setString('userPassword', user.password);
    prefs.setString('userType', user.userType);
    prefs.setBool('isRegister', true);
    _names = user.names;
    _adresse = AdresseModel(
      ville: user.adresse.ville,
      commune: user.adresse.commune,
      quartier: user.adresse.quartier,
      cellule: user.adresse.cellule,
      avenue: user.adresse.avenue,
      num: user.adresse.num,
    );
    _imgUrl = user.imgUrl;
    _email = user.email;
    _num = user.num;
    _password = user.password;
    _userType = user.userType;
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
    _password = prefs.getString('userPassword');
    debugPrint("$_email || $_num || $_password");
    if ((_email == userKey || _num == userKey) && (_password != userWords)) {
      myCustomSnackBar(
        context: context,
        text: "Mots de passe incorrect",
      );
    } else if ((_email != userKey && _num != userKey) &&
        (_password == userWords)) {
      myCustomSnackBar(
        context: context,
        text: "Email/N° Tél incorrect",
      );
    } else if ((_email == userKey || _num == userKey) &&
        (_password == userWords)) {
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
