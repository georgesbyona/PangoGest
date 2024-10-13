import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class FireStoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final users = FirebaseFirestore.instance.collection("users");

  Future<void> registerUser(UserModel user, String ownerEmail) async {
    if (ownerEmail.isNotEmpty) {
      debugPrint("${ownerEmail.isNotEmpty}");
      try {
        await users.doc(ownerEmail).collection("tenants").doc(user.email).set({
          "firstName": user.firstName,
          "lastName": user.lastName,
          "email": user.email,
          "num": user.num,
          "password": user.password,
          "userType": user.userType,
          "imgUrl": user.imgUrl,
        });
      } catch (e) {
        e.toString();
      }
    } else {
      try {
        await users.doc(user.email).set({
          "firstName": user.firstName,
          "lastName": user.lastName,
          "email": user.email,
          "num": user.num,
          "password": user.password,
          "userType": user.userType,
          "imgUrl": user.imgUrl,
        });
      } catch (e) {
        e.toString();
      }
    }
  }

  Future<void> userAddressUpdate(email, AddressModel address) async {
    await users.doc(email).set({
      "address":
          "N° ${address.num}, Av. ${address.avenue}, Q. ${address.quartier}, C. ${address.commune}, V. ${address.ville}"
    });
  }

  Future<void> userHouseUpdate(email, houseID) async {
    await users.doc(email).set({"addressID": houseID});
  }

  Future getUsers() async {
    debugPrint('Taper');
    try {
      debugPrint('Stream');
      users.snapshots().map(
        (e) {
          final doc = e.docs.first;
          debugPrint("${doc.exists}");
        },
      );
    } catch (e) {
      e.toString();
    }
  }
}
