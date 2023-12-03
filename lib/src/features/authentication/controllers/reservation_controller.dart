import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/complaint_model.dart';
import 'package:psm_project/src/repository/user_repository.dart';

import '../models/reservation_model.dart';

enum LocationChoice { Field, Hall, Mosque }


class ReservationController extends GetxController {
  static  ReservationController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final location = TextEditingController();
  final description = TextEditingController();


  final userRepo = Get.put(UserRepository());


  Future <void> createReservation(ReservationModel reservation) async {
    await userRepo.createReservation(reservation);
  }

  Future<List<ReservationModel>> getAllReservation() async {
    return await userRepo.allReservation();
  }

  Future<ReservationModel> getReservationDetailsById(String id) async {
    return userRepo.getReservationDetailsById(id);
  }

  updateReservation(ReservationModel reservation) async {
    try {
      // Check if the user document exists before updating
      final reservationDoc = await userRepo.getReservationDetails(reservation.id);

      if (reservationDoc != null) {
        await userRepo.updateReservationRecord(reservation);
        Get.snackbar("Success", "Reservation record updated successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "Reservation record not found.",
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

  deleteReservation(String id) async {
    try {
      // Check if the user document exists before deleting
      final reservationDoc = await userRepo.getReservationDetailsById(id);

      if (reservationDoc != null) {
        await userRepo.deleteReservation(id);

        // Show Snackbar outside the try block
        Get.snackbar("Success", "Reservation deleted successfully.",
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
      print("Error deleting reservation: $error");
    }
  }
}