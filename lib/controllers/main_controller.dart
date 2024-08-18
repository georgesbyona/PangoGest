import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';

class MainController extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  int index = 0;

  void navigationController(int i) {
    index = i;
    notifyListeners();
  }

  Future<void> sendFeedback({
    BuildContext? context,
    String? name,
    String? email,
    String? content,
  }) async {
    String? phoneInfo;
    checkConnection(context);
    if (isConnected) {
      final deviceInfo = DeviceInfoPlugin();
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        phoneInfo = androidInfo.model;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        phoneInfo = iosInfo.model;
        debugPrint(phoneInfo);
      }
      myCustomSnackBar(
        context: context,
        text: 'Merci pour votre feedback',
      );
    }
    notifyListeners();
  }

  void changeThemeMode({bool? darkMode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (darkMode != null) {
      _isDark = darkMode;
    } else {
      _isDark = !isDark;
      sharedPreferences.setBool('isDark', isDark);
    }
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
