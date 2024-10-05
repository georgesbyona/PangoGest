import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class UserDataController extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  String? _names;
  String? _imgUrl;
  String? _email;
  String? _num;
  String? _password;
  String? _userType;
  AddressModel? _userAddress;
  bool _isLoggedIn = false;
  bool _isRegister = false;

  String? get names => _names;
  String? get imgUrl => _imgUrl;
  AddressModel? get address => _userAddress;
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
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _password = prefs.getString('userPassword');
    _userType = prefs.getString('userType');
    _isRegister = prefs.getBool('isRegister') ?? false;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (names != null) {
      _userAddress = AddressModel(
        id: int.parse(prefs.getString('userAID')!),
        ville: prefs.getString('userT')!,
        commune: prefs.getString('userC')!,
        quartier: prefs.getString('userQ')!,
        cellule: prefs.getString('userC')!,
        avenue: prefs.getString('userA')!,
        num: prefs.getString('userN')!,
      );
    }
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

  Future<void> registerUser(UserModel user, AddressModel address) async {
    isRegisterUser = true;
    final userName = "${user.firstName} ${user.lastName}";
    final prefs = await _prefs;
    prefs.setString('userNames', userName);
    prefs.setString('userImgUrl', user.imgUrl!);
    prefs.setString('userEmail', user.email!);
    prefs.setString('userNum', user.num);
    prefs.setString('userPassword', user.password);
    prefs.setString('userType', user.userType);
    prefs.setString('userAID', user.adresseID.toString());
    prefs.setString('userT', address.ville);
    prefs.setString('userC', address.commune);
    prefs.setString('userQ', address.quartier);
    prefs.setString('userC', address.cellule);
    prefs.setString('userA', address.avenue);
    prefs.setString('userN', address.num);
    prefs.setBool('isRegister', true);
    prefs.setBool('isLoggedIn', true);
    _names = userName;
    _email = user.email;
    _num = user.num;
    _imgUrl = user.imgUrl;
    _password = user.password;
    _userType = user.userType;
    _userAddress = AddressModel(
      id: user.adresseID!,
      ville: address.ville,
      commune: address.commune,
      quartier: address.quartier,
      cellule: address.cellule,
      avenue: address.avenue,
      num: address.num,
    );
    _isRegister = true;
    _isLoggedIn = true;
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
