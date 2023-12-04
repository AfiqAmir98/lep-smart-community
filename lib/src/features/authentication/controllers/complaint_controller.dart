import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/complaint_model.dart';
import 'package:psm_project/src/repository/user_repository.dart';

enum TitleChoice { Road, Streetlight, Enviroment }


class ComplaintController extends GetxController {
  static  ComplaintController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final location = TextEditingController();
  final description = TextEditingController();

  final userRepo = Get.put(UserRepository());


  Future <void> createComplaint(ComplaintModel complaint) async {
    await userRepo.createComplaint(complaint);
  }

  Future<List<ComplaintModel>> getAllComplaintbyEmail(String userEmail) async {
    return await userRepo.allComplaintbyEmail(userEmail);
  }

  Future<List<ComplaintModel>> getAllComplaint() async {
    return await userRepo.allComplaint();
  }

  Future<ComplaintModel> getComplaintDetailsById(String id) async {
    return userRepo.getComplaintDetailsById(id);
  }

  updateComplaint(ComplaintModel complaint) async {
    try {
      // Check if the user document exists before updating
      final complaintDoc = await userRepo.getComplaintDetails(complaint.id);

      if (complaintDoc != null) {
        await userRepo.updateComplaintRecord(complaint);
        Get.snackbar("Success", "User record updated successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "Complaint record not found.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error updating record: $error");
    }
  }

  deleteComplaint(String id) async {
    try {
      // Check if the user document exists before deleting
      final userDoc = await userRepo.getComplaintDetailsById(id);

      if (userDoc != null) {
        await userRepo.deleteComplaint(id);

        // Show Snackbar outside the try block
        Get.snackbar("Success", "User deleted successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);

        // Navigate back to the list view screen
        Get.until((route) => Get.currentRoute == '/ProfileScreen');
      } else {
        Get.snackbar("Error", "Record not found.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error deleting complaint: $error");
    }
  }
}