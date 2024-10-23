import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

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
    checkConnection(context!);
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

  Future<void> checkConnection(BuildContext context) async {
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

  List<HouseModel> houses = [];
  List<AddressModel> housesAddress = [];

  Future<bool> addHouse(HouseModel house) async {
    try {
      final response = await RealEstateAPI.createRealEstate(house);
      houses.add(response.last);
      readHouses();
      return response.first;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> readHouses() async {
    final housesList = await RealEstateAPI.readRealEstate();
    if (housesList != null) {
      for (var h in housesList) {
        final house = HouseModel.fromJson(h);
        await loadHousesAddress(house.id!);
        houses.add(house);
      }
    }
  }

  Future<void> loadHousesAddress(int id) async {
    final houseAddress = await AddressAPI.checkAddress(id);
    if (houseAddress != null) {
      housesAddress.add(houseAddress);
    }
  }

  Future<bool> deleteHouse(int id) async {
    final deleted = await RealEstateAPI.deleteRealEstate(id);
    notifyListeners();
    return deleted;
  }

  dynamic selectedFile;

  Future pickImgFromGallery(context) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.media);
      if (result != null) {
        final extension = result.files.first.extension;
        if (extension == 'png' || extension == 'jpg' || extension == 'jpeg') {
          try {
            final file = result.files.first;
            selectedFile = File(file.path!);
            notifyListeners();
          } catch (e) {
            await FilePicker.platform.clearTemporaryFiles();
            myCustomSnackBar(
              context: context,
              text: "Impossible d'ajouter l'image, réessayer plus tard",
            );
          }
        } else {
          myCustomSnackBar(
            context: context,
            text: "Veuillez sélectionner une image (jpg, jpeg ou png)",
          );
        }
      }
    } catch (e) {
      await FilePicker.platform.clearTemporaryFiles();
      myCustomSnackBar(
        context: context,
        text: "Impossible d'ajouter l'image, veuillez réessayer",
      );
      Navigator.pop(context);
    }
    notifyListeners();
  }

  Future<String> uploadImage(File imageFile) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final imageRef = storageRef.child(
      'houses/${DateTime.now().millisecondsSinceEpoch}',
    );
    try {
      await imageRef.putFile(imageFile);
      final downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return "";
    }
  }

  DateTime? _contractDate;

  dynamic get contractDate => _contractDate == null
      ? DateFormat('yyyy-MM-dd').format(DateTime.now())
      : DateFormat('yyyy-MM-dd').format(_contractDate!);

  Future<void> pickDate(BuildContext context) async {
    _contractDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (_contractDate != null) {}
    notifyListeners();
  }

  String? currentHouse;

  void pickHouseID(String? currentID) {
    currentHouse = currentID;
    notifyListeners();
  }
}
