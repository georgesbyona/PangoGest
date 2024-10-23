import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class UserDBServices {
  static final users = FirebaseFirestore.instance.collection("users");

  static Future<bool> checkUser(String email, String ownerEmail) async {
    bool isExist = false;
    if (ownerEmail.isEmpty) {
      final docRef = users.doc(email);
      try {
        await docRef.get().then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            isExist = snapshot.exists;
          } else {
            isExist = snapshot.exists;
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      final docRef = users.doc(ownerEmail).collection("tenants").doc(email);
      try {
        await docRef.get().then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            isExist = snapshot.exists;
          } else {
            isExist = snapshot.exists;
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return isExist;
  }

  static Future<bool> registerUser(UserModel user, String ownerEmail) async {
    if (ownerEmail.isNotEmpty) {
      try {
        await users.doc(ownerEmail).collection("tenants").doc(user.email).set({
          "firstName": user.firstName,
          "lastName": user.lastName,
          "email": user.email,
          "num": user.num,
          "password": user.password,
          "userType": user.userType,
          "imgUrl": user.imgUrl,
          "ownerEmail": ownerEmail,
        });
        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
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
        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
  }

  static Future<bool> userAddressUpdate(
    String email,
    AddressModel address,
  ) async {
    try {
      await users.doc(email).update({
        "address":
            "N° ${address.num}/Av. ${address.avenue}/Q. ${address.quartier}/C. ${address.commune}/V. ${address.ville}"
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> userHouseUpdate(email, houseID) async {
    await users.doc(email).set({"addressID": houseID});
  }

  void getUsers() {
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

  // Future<bool> checkUser(String email, String ownerEmail) async {
  //   bool userExist = false;
  //   try {
  //     if (ownerEmail.isEmpty) {
  //       users.doc(email).snapshots().map(
  //         (e) {
  //           userExist = e.exists;
  //         },
  //       );
  //       debugPrint('User exist ? $userExist');
  //       return userExist;
  //     } else {
  //       users.doc(ownerEmail).collection("tenants").doc(email).snapshots().map(
  //         (e) {
  //           userExist = e.exists;
  //         },
  //       );
  //     }
  //     debugPrint('User exist ? $userExist');
  //     return userExist;
  //   } catch (e) {
  //     e.toString();
  //     return false;
  //   }
  // }

  // Future<UserModel?> getUser(String email, String password) async {
  //   if (ownerEmail.isEmpty) {
  //     final docRef = users.doc(email);
  //     try {
  //       await docRef.get().then((DocumentSnapshot snapshot) {
  //         if (snapshot.exists) {
  //           isExist = snapshot.exists;
  //         } else {
  //           isExist = snapshot.exists;
  //         }
  //       });
  //     } catch (e) {
  //       debugPrint(e.toString());
  //     }
  //   } else {
  //     final docRef = users.doc(ownerEmail).collection("tenants").doc(email);
  //     try {
  //       await docRef.get().then((DocumentSnapshot snapshot) {
  //         if (snapshot.exists) {
  //           isExist = snapshot.exists;
  //         } else {
  //           isExist = snapshot.exists;
  //         }
  //       });
  //     } catch (e) {
  //       debugPrint(e.toString());
  //     }
  //   }
  // }
}
