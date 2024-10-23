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
  String? _ownerEmail;
  AddressModel? _userAddress;
  bool _isLoggedIn = false;
  bool _isRegister = false;

  int? get userID => _userID;
  String? get names => _names;
  String? get imgUrl => _imgUrl;
  AddressModel? get address => _userAddress;
  String? get email => _email;
  String? get num => _num;
  String? get password => _password;
  String? get userType => _userType;
  String? get ownerEmail => _ownerEmail;
  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;

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
    // if (_isRegister) {
    //   final address = await AddressAPI.checkAddress(_userAddress!.id!);
    //   _userAddress = AddressModel(
    //     id: prefs.getInt('userAID'),
    //     ville: prefs.getString('userT')!,
    //     commune: prefs.getString('userC')!,
    //     quartier: prefs.getString('userQ')!,
    //     cellule: prefs.getString('userCell'),
    //     avenue: prefs.getString('userA')!,
    //     num: prefs.getString('userN')!,
    //   );
    // }

    if (_userID != null) {
      await loadUsers();
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

  Future<bool> registerUser(
    UserModel user, {
    String email = "",
    BuildContext? context,
    bool fromConnection = false,
  }) async {
    final userName = "${user.firstName} ${user.lastName}";
    final prefs = await _prefs;
    if (fromConnection) {
      prefs.setInt('userID', user.id!);
      prefs.setString('userNames', userName);
      prefs.setString('userImgUrl', user.imgUrl!);
      prefs.setString('userEmail', user.email);
      prefs.setString('userNum', user.num);
      prefs.setString('userPassword', user.password);
      prefs.setString('userType', user.userType);
      prefs.setString('ownerEmail', user.ownerEmail);
      _userID = user.id;
      _names = userName;
      _email = user.email;
      _num = user.num;
      _imgUrl = user.imgUrl;
      _password = user.password;
      _userType = user.userType;
      _ownerEmail = user.ownerEmail;
      debugPrint('======================= User $_names succefully register');
      notifyListeners();
      return true;
    } else {
      // final userExist = await UserAPI.checkUser(user.id);

      final register = await UserAPI.registerUser(user);
      if (register.first == true) {
        prefs.setInt('userID', register.last);
        prefs.setString('userNames', userName);
        prefs.setString('userImgUrl', user.imgUrl!);
        prefs.setString('userEmail', user.email);
        prefs.setString('userNum', user.num);
        prefs.setString('userPassword', user.password);
        prefs.setString('userType', user.userType);
        prefs.setString('ownerEmail', user.ownerEmail);
        _userID = user.id;
        _names = userName;
        _email = user.email;
        _num = user.num;
        _imgUrl = user.imgUrl;
        _password = user.password;
        _userType = user.userType;
        _ownerEmail = user.ownerEmail;
        debugPrint('======================= User $_names succefully register');
        notifyListeners();
        return true;
      } else if (register.first == null) {
        myCustomSnackBar(context: context, text: register.last);
        notifyListeners();
        return false;
      } else {
        return false;
      }
    }
  }

  Future<bool> registerAddress(
    AddressModel address, {
    bool fromConnection = false,
  }) async {
    final prefs = await _prefs;
    final registered = await AddressAPI.registerAddress(address);
    if (fromConnection) {
      prefs.setInt('userAID', address.id!);
      prefs.setString('userT', address.ville);
      prefs.setString('userC', address.commune);
      prefs.setString('userQ', address.quartier);
      prefs.setString('userCell', address.cellule!);
      prefs.setString('userA', address.avenue);
      prefs.setString('userN', address.num);
      prefs.setBool('isRegister', true);
      prefs.setBool('isLoggedIn', true);
      _userAddress = AddressModel(
        id: address.id,
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
      if (registered.first) {
        await UserAPI.userAddressUpdate(_userID!, registered.last);
        prefs.setInt('userAID', registered.last);
        prefs.setString('userT', address.ville);
        prefs.setString('userC', address.commune);
        prefs.setString('userQ', address.quartier);
        prefs.setString(
            'userCell', address.cellule != null ? address.cellule! : "");
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
  }

  Future<bool> connectUser(
    BuildContext context,
    String userKey,
    String userPassword,
  ) async {
    final prefs = await _prefs;
    final connected = await UserAPI.connectUser(userKey, userPassword);
    if (connected.first == true) {
      final address = await AddressAPI.checkAddress(connected.last.addressID);
      await registerUser(connected.last, fromConnection: true);
      await registerAddress(address.last, fromConnection: true);
      prefs.setBool('isRegister', true);
      prefs.setBool('isLoggedIn', true);
      _isRegister = true;
      _isLoggedIn = true;
      await loadUserData();
      Navigator.pop(context);
      Navigator.pop(context);
      notifyListeners();
      return true;
    } else if (connected.first == null) {
      myCustomSnackBar(
        context: context,
        text: connected.last,
      );
      notifyListeners();
      return false;
    } else {
      myCustomSnackBar(
        context: context,
        text: connected.last,
      );
      notifyListeners();
      return false;
    }
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

  List<UserModel> usersList = [];
  Future<void> loadUsers() async {
    final users = await ContractAPI.getOwner(
      UserModel(
        id: _userID,
        firstName: _names!.split(" ")[0],
        lastName: _names!.split(" ")[1],
        email: _email!,
        num: _num!,
        password: _password!,
        userType: _userType!,
        // addressID: _userAddress!.id,
        imgUrl: _imgUrl,
        ownerEmail: _ownerEmail ?? "",
      ),
    );
    if (users.last != null) {
      for (var u in users.last) {
        usersList.add(u);
      }
      debugPrint("Users successfully loaded");
      notifyListeners();
    }
  }
}
