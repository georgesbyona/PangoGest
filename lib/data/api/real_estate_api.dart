import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data.dart';

class RealEstateAPI {
  // http://34.45.123.91:8080/
  static String baseUrl = "https://projettutorepangogest.onrender.com/api";

  static Future<List> createRealEstate(HouseModel house) async {
    final url = Uri.parse("$baseUrl/bien_imobilier/");
    var body = jsonEncode(
      {
        "photo_url": house.photo,
        "surface": house.surface,
        "description": house.description,
        "prix": house.price,
        "adresse": house.addressID,
        "utilisateur": house.userID,
      },
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 201) {
        final myJson = jsonDecode(response.body);
        final data = HouseModel.fromJson(myJson);
        return [true, data];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return [false, null];
      }
    } catch (e) {
      debugPrint("Post Error : $e");
      return [false, null];
    }
  }

  static Future readRealEstate() async {
    final url = Uri.parse("$baseUrl/bien_imobilier/");
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        debugPrint("Houses successfully read.");
        final myJson = jsonDecode(response.body);
        // final data = HouseModel.fromJson(myJson);
        return myJson;
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return;
      }
    } catch (e) {
      debugPrint("Post Error : $e");
      return;
    }
  }

  static Future<bool> deleteRealEstate(int id) async {
    final url = Uri.parse("$baseUrl/bien_imobilier/$id");
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 204) {
        debugPrint("Houses successfully deleted.");
        return true;
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Post Error : $e");
      return false;
    }
  }

  static Future<HouseModel?> getTenantHouse(int id) async {
    final url = Uri.parse("$baseUrl/contrat_location/maison_par_locataire/");
    var body = jsonEncode({"locataire_id": id});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 200) {
        final myJson = jsonDecode(response.body);
        final data = HouseModel.fromJson(myJson.first);

        debugPrint("Maison : ${response.body}");
        return data;
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Post Error : $e");
      return null;
    }
  }
}
