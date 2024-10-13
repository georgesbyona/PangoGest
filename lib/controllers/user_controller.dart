import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class UserDataController extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  int? _userID;
  String? _names;
  String? _imgUrl;
  String? _email;
  String? _num;
  String? _password;
  String? _userType;
  AddressModel? _userAddress;
  bool _isLoggedIn = false;
  bool _isRegister = false;
  bool _userExist = false;

  int? get userID => _userID;
  String? get names => _names;
  String? get imgUrl => _imgUrl;
  AddressModel? get address => _userAddress;
  String? get email => _email;
  String? get num => _num;
  String? get password => _password;
  String? get userType => _userType;
  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;

  bool get userExist => _userExist;

  Future<void> loadUserData() async {
    final prefs = await _prefs;
    _userID = prefs.getInt('userID');
    _names = prefs.getString('userNames');
    _imgUrl = prefs.getString('userImgUrl');
    _email = prefs.getString('userEmail');
    _num = prefs.getString('userNum');
    _password = prefs.getString('userPassword');
    _userType = prefs.getString('userType');
    _isRegister = prefs.getBool('isRegister') ?? false;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (_isRegister) {
      _userAddress = AddressModel(
        id: prefs.getInt('userAID')!,
        ville: prefs.getString('userT')!,
        commune: prefs.getString('userC')!,
        quartier: prefs.getString('userQ')!,
        cellule: prefs.getString('userC')!,
        avenue: prefs.getString('userA')!,
        num: prefs.getString('userN')!,
      );
    }
    _userExist = await UserAPI.checkUser(_userID);
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

  Future<bool> registerUser(UserModel user) async {
    final userName = "${user.firstName} ${user.lastName}";
    final prefs = await _prefs;
    final registered = await UserAPI.registerUser(user);
    if (registered.first) {
      prefs.setInt('userID', registered.last);
      prefs.setString('userNames', userName);
      prefs.setString('userImgUrl', user.imgUrl!);
      prefs.setString('userEmail', user.email);
      prefs.setString('userNum', user.num);
      prefs.setString('userPassword', user.password);
      prefs.setString('userType', user.userType);
      _userID = registered.last;
      _names = userName;
      _email = user.email;
      _num = user.num;
      _imgUrl = user.imgUrl;
      _password = user.password;
      _userType = user.userType;
      debugPrint('======================= User $_names succefully register');
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerAddress(AddressModel address) async {
    final prefs = await _prefs;
    final registered = await AddressAPI.registerAddress(_userID!, address);
    if (registered.first) {
      await UserAPI.userAddressUpdate(_userID!, registered.last);
      prefs.setInt('userAID', registered.last);
      prefs.setString('userT', address.ville);
      prefs.setString('userC', address.commune);
      prefs.setString('userQ', address.quartier);
      prefs.setString('userC', address.cellule != null ? address.cellule! : "");
      prefs.setString('userA', address.avenue);
      prefs.setString('userN', address.num);
      prefs.setBool('isRegister', true);
      prefs.setBool('isLoggedIn', true);
      _userAddress = AddressModel(
        id: registered.last,
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
      debugPrint('================== isRegister ? $_isRegister');
      notifyListeners();
      return true;
    } else {
      debugPrint('================== isRegister ? $_isRegister');
      notifyListeners();
      return false;
    }
  }

  Future<void> connectUser(
    BuildContext context,
    String userKey,
    String userPassword,
  ) async {
    final prefs = await _prefs;
    // _email = prefs.getString('userEmail');
    // _num = prefs.getString('userNum');
    // _password = prefs.getString('userPassword');
    // debugPrint("$_email || $_num || $_password");
    final connected = await UserAPI.connectUser(userKey, userPassword);
    if (connected.first == true) {
      prefs.setInt('userAID', connected.last);
      prefs.setBool('isLoggedIn', true);
      await loadUserData();
      _isLoggedIn = true;
      Navigator.pop(context);
      Navigator.pop(context);
    } else if (connected.first == null) {
      myCustomSnackBar(
        context: context,
        text: connected.last,
      );
    } else {
      myCustomSnackBar(
        context: context,
        text: connected.last,
      );
    }
    // if ((_email == userKey || _num == userKey) && (_password != userPassword)) {
    // } else if ((_email != userKey && _num != userKey) &&
    //     (_password == userPassword)) {
    // } else if ((_email == userKey || _num == userKey) &&
    //     (_password == userPassword)) {
    // } else {
    // }
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
