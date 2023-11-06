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
}