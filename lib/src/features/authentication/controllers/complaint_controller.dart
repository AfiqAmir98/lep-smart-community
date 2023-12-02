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

  Future<List<ComplaintModel>> getAllComplaint() async {
    return await userRepo.allComplaint();
  }
}