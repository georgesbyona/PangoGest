import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data.dart';

class ContractAPI {
  // final String apiKey = "http://34.45.123.91:8080";
  static String baseUrl = "https://projettutorepangogest.onrender.com/api";

  static Future<bool> createContract(ContractModel contract) async {
    final url = Uri.parse("$baseUrl/contrat_location/register_contrat/");
    var body = jsonEncode(
      {
        "date_contrat": contract.dateContrat,
        "date_debut": contract.dateDebut,
        "prix": contract.price,
        "fichier": contract.docUrl,
        "duree_mois": contract.duree,
        "encours": contract.inProgress,
        "locataire": contract.tenantID,
        "bien": contract.houseID,
        "email": contract.tenantEmail,
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
        debugPrint("JSON Body : $myJson");
        // final data = ContractModel.fromJson(myJson);
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

  static Future<bool> verificationMotCle(String email, String keyWord) async {
    final url = Uri.parse("$baseUrl/contrat_location/verifier_mot_cle/");
    var body = jsonEncode(
      {
        "email": email,
        "mot_cle": keyWord,
      },
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 200) {
        final myJson = jsonDecode(response.body);
        debugPrint("JSON Body : $myJson");
        // final data = ContractModel.fromJson(myJson);
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

  static Future<List> getOwner(UserModel user) async {
    final url = user.userType == "locataire"
        ? Uri.parse("$baseUrl/contrat_location/bailleur_par_locataire/")
        : Uri.parse("$baseUrl/contrat_location/locataires_par_bailleur/");
    final field = user.userType == "locataire" ? "locataire_id" : "bailleur_id";
    var body = jsonEncode({field: user.id});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 200) {
        List datas = [];
        final myJson = jsonDecode(response.body);
        if (user.userType == "bailleur") {
          final userExist1 = await UserDBServices.checkUser(user.email, "");
          final isExist1 = await ChatDBServices.checkUser(user.email, "");
          for (var jSon in myJson) {
            final data = UserModel.fromJson(jSon);
            datas.add(data);
            final userExist2 =
                await UserDBServices.checkUser(data.email, user.email);
            final isExist2 =
                await ChatDBServices.checkUser(data.email, user.email);
            if (!userExist2) {
              await UserDBServices.registerUser(data, user.email);
            }
            if (!isExist2) {
              await ChatDBServices.registerUChat(
                ChatModel(
                  email: data.email,
                  names: "${data.firstName} ${data.lastName}",
                  imgUrl: data.imgUrl,
                  messages: [],
                ),
                user.email,
              );
            }
          }
          if (!userExist1) {
            await UserDBServices.registerUser(user, "");
          }
          if (!isExist1) {
            await ChatDBServices.registerUChat(
              ChatModel(
                email: user.email,
                names: "${user.firstName} ${user.lastName}",
                imgUrl: user.imgUrl,
                messages: [],
              ),
              "",
            );
          }
          return [true, datas];
        } else {
          final data = UserModel.fromJson(myJson.first);
          final userExist =
              await UserDBServices.checkUser(user.email, data.email);
          final isExist =
              await ChatDBServices.checkUser(user.email, data.email);
          if (!userExist) {
            await UserDBServices.registerUser(user, data.email);
          }
          if (!isExist) {
            await ChatDBServices.registerUChat(
              ChatModel(
                email: user.email,
                names: "${user.firstName} ${user.lastName}",
                imgUrl: user.imgUrl,
                messages: [],
              ),
              data.email,
            );
          }
          return [true, data];
        }
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
}
