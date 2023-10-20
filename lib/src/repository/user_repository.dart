import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async{
    await _db.collection("User").add(user.toJson()).whenComplete(
          () => Get.snackbar("Success", "An Account has been created.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green),
        )
    .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    print('Fetching user details for email: $email');
    final snapshot = await _db.collection("User").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("User").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }


}