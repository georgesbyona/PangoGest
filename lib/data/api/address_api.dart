import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data.dart';

class AddressAPI {
  // static String baseUrl = "http://192.168.196.133:8000/api";
  // static String baseUrl = "http://34.45.123.91:8080/api";
  static String baseUrl = "https://projettutorepangogest.onrender.com/api";

  static Future<List> registerAddress(
    AddressModel address,
  ) async {
    final url = Uri.parse("$baseUrl/adresse/");
    var body = jsonEncode(
      {
        "ville": "Bukavu",
        "commune": address.commune,
        "quartier": address.quartier,
        "cellule": address.cellule,
        "avenue": address.avenue,
        "num_av": address.num.isNotEmpty ? address.num : "0000",
      },
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 201) {
        debugPrint("================== Address successfully created");
        final myJson = jsonDecode(response.body);
        return [true, myJson['id']];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("Error : ${response.statusCode}");
        return [false, null];
      }
    } catch (e) {
      debugPrint("Erreur lors du post : $e");
      return [false, null];
    }
  }

  static Future<List> checkAddress(int addressID) async {
    final url = Uri.parse("$baseUrl/adresse/$addressID/");
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        final myJson = jsonDecode(response.body);
        final data = AddressModel.fromJson(myJson);
        return [true, data];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return [true, null];
      }
    } catch (e) {
      debugPrint("Erreur lors de get : $e");
      return [false, null];
    }
  }
}
