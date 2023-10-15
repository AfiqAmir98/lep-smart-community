import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';

enum UserRole { resident, admin, maintenance }

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final address = TextEditingController();
  final icNo = TextEditingController();

  // Call this Function from Design & it will do the rest
  void registerUser(String email, String password, UserRole role) {
    String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password, role) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
