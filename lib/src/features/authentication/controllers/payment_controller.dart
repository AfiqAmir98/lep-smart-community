import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/complaint_model.dart';
import 'package:psm_project/src/repository/user_repository.dart';

import '../models/payment_model.dart';



class PaymentController extends GetxController {
  static  PaymentController get instance => Get.find();

  final userRepo = Get.put(UserRepository());


  Future <void> createPayment(PaymentModel payment) async {
    await userRepo.createPayment(payment);
  }

  Future<List<PaymentModel>> allPayment() async {
    return await userRepo.allPayment();
  }

  Future<PaymentModel> getPaymentDetailsById(String id) async {
    return userRepo.getPaymentDetailsById(id);
  }

  updatePayment(PaymentModel payment) async {
    try {
      // Check if the user document exists before updating
      final paymentDoc = await userRepo.getPaymentDetails(payment.id);

      if (paymentDoc != null) {
        await userRepo.updatePaymentRecord(payment);
        Get.snackbar("Success", "Payment record updated successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "Payment record not found.",
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

  deletePayment(String id) async {
    try {
      // Check if the user document exists before deleting
      final paymentDoc = await userRepo.getPaymentDetailsById(id);

      if (paymentDoc != null) {
        await userRepo.deletePayment(id);

        // Show Snackbar outside the try block
        Get.snackbar("Success", "Payment deleted successfully.",
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