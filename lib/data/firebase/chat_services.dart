import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class ChatDBServices {
  static final chats = FirebaseFirestore.instance.collection("chats");

  static Future<bool> registerUChat(ChatModel user, String ownerEmail) async {
    if (ownerEmail.isNotEmpty) {
      try {
        await chats.doc(ownerEmail).collection("tenants").doc(user.email).set({
          "email": user.email,
          "names": user.names,
          "imgUrl": user.imgUrl,
          "messages": user.messages,
        });
        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    } else {
      try {
        await chats.doc(user.email).set({
          "email": user.email,
          "names": user.names,
          "imgUrl": user.imgUrl,
          "messages": user.messages,
        });
        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
  }

  static Future<bool> checkUser(String email, String ownerEmail) async {
    bool isExist = false;
    if (ownerEmail.isEmpty) {
      final docRef = chats.doc(email);
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
      final docRef = chats.doc(ownerEmail).collection("tenants").doc(email);
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getTenants(String email) {
    return chats.doc(email).collection("tenants").snapshots();
  }

  static Future<void> addMessage(
    String ownerEmail,
    String email,
    List<Map<String, dynamic>> messages,
  ) async {
    try {
      await chats
          .doc(ownerEmail)
          .update({"messages": FieldValue.arrayUnion(messages)});
      await chats
          .doc(ownerEmail)
          .collection("tenants")
          .doc(email)
          .update({"messages": FieldValue.arrayUnion(messages)});
    } catch (e) {
      debugPrint("Adding message error : ${e.toString()}");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOwner(String email) {
    return chats.snapshots();
  }
  // static Future<ChatModel?> getOwner(String email) async {
  //   ChatModel? owner;
  //   try {
  //     final doc = await chats.doc(email).get();
  //     owner = ChatModel.fromJson(doc.data());
  //     return owner;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return owner;
  //   }
  // }
}
