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
}