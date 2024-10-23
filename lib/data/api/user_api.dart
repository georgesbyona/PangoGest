import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data.dart';

class UserAPI {
  // static String baseUrl = "http://192.168.196.133:8000/api";
  // static String baseUrl = "http://34.45.123.91:8080/api";
  static String baseUrl = "https://projettutorepangogest.onrender.com/api";

  static Future<List> registerUser(UserModel user) async {
    final url = Uri.parse("$baseUrl/utilisateurs/");
    var body = jsonEncode(
      {
        "username": user.email,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "email": user.email,
        "telephone": user.num,
        "photo_url": user.email == "georgesbyona@gmail.com"
            ? "https://lh3.googleusercontent.com/a/ACg8ocLrFO4QlXqP0Elvw0cspu9YMHbut7Os8iSPpfxtzo6NTJZtw5s=s96-c"
            : "https://firebasestorage.googleapis.com/v0/b/pangogest.appspot.com/o/profil.png?alt=media&token=800f4279-9fb1-463f-8add-c0f485310caa",
        "password": user.password,
        "user_type": user.userType,
      },
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 201) {
        debugPrint("User successfully created. Code ${response.statusCode}");
        final myJson = jsonDecode(response.body);
        return [true, myJson['id']];
      } else if (response.statusCode == 400) {
        return [null, "Utilisateur existant, veuillez vous connecter"];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return [false, null];
      }
    } catch (e) {
      debugPrint("Post error : $e");
      return [false, null];
    }
  }

  static Future<List> connectUser(String email, String password) async {
    final url = Uri.parse("$baseUrl/utilisateurs/login/");
    var body = jsonEncode(
      {
        "email": email,
        "password": password,
      },
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 200) {
        debugPrint("User $email's successfully connected");
        final myJson = jsonDecode(response.body);
        final data = UserModel.fromJson(myJson);
        return [true, data];
      } else if (response.statusCode == 401) {
        return [null, "Mot de passe invalide"];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return [false, "Utilisateur non existant"];
      }
    } catch (e) {
      debugPrint("Connect user error : $e");
      return [false, "Utilisateur non existant"];
    }
  }

  static Future<List> userAddressUpdate(int userID, int addressID) async {
    try {
      final url = Uri.parse("$baseUrl/utilisateurs/$userID/");
      var body = jsonEncode(
        {
          "id_adresse": addressID,
        },
      );
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 200) {
        final myJson = jsonDecode(response.body);
        return [true, myJson['id']];
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return [false, null];
      }
    } catch (e) {
      debugPrint("User adresse update error : $e");
      return [false, null];
    }
  }

  static Future<bool> checkUser(int? userID) async {
    final url = Uri.parse("$baseUrl/utilisateurs/$userID/");
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Checking error : $e");
      return false;
    }
  }

  static Future<bool> userDeleted(int? userID) async {
    debugPrint("$userID");
    final url = Uri.parse("$baseUrl/utilisateurs/$userID/");
    var body = jsonEncode(
      {
        "id": userID,
      },
    );
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        debugPrint("Body : ${response.body}");
        debugPrint("StatusCode Error : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Delete error : $e");
      return false;
    }
  }
}
