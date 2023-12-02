import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';
import 'package:psm_project/src/repository/authentication_repository/authentication_repository.dart';
import 'package:psm_project/src/repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance =>Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());


  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.getUserDetails(email);
    }
    Get.snackbar("Error", "Login to Continue");
  }

  Future<UserModel> getUserDetailsById(String userId) async {
    return _userRepo.getUserDetailsById(userId);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.allUser();
  }

  updateRecord(UserModel user) async {
    try {
      // Check if the user document exists before updating
      final userDoc = await _userRepo.getUserDetails(user.email);

      if (userDoc != null) {
        await _userRepo.updateUserRecord(user);
        Get.snackbar("Success", "User record updated successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "User record not found.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error updating user record: $error");
    }
  }

  deleteUser(String userId) async {
    try {
      // Check if the user document exists before deleting
      final userDoc = await _userRepo.getUserDetailsById(userId);

      if (userDoc != null) {
        await _userRepo.deleteUser(userId);

        // Show Snackbar outside the try block
        Get.snackbar("Success", "User deleted successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);

        // Navigate back to the list view screen
        Get.until((route) => Get.currentRoute == '/ProfileScreen');
      } else {
        Get.snackbar("Error", "User not found.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error deleting user: $error");
    }
  }
}