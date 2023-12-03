import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';

import '../features/authentication/models/complaint_model.dart';
import '../features/authentication/models/payment_model.dart';
import '../features/authentication/models/reservation_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

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
//Complaint
  createComplaint(ComplaintModel complaint) async{
    await _db.collection("Complaint").add(complaint.toJson()).whenComplete(
          () => Get.snackbar("Success", "A Complaint has been created.",
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

  Future<List<ComplaintModel>> allComplaint() async {
    final snapshot = await _db.collection("Complaint").get();
    final complaintData = snapshot.docs.map((e) => ComplaintModel.fromSnapshot(e)).toList();
    return complaintData;
  }

  Future<ComplaintModel?> getComplaintDetails(String? id) async {
    if (id == null) {
      return null;
    }
    print('Fetching complaint details for id: $id');
    final snapshot = await _db.collection("Complaint").doc(id).get();
    if (snapshot.exists) {
      return ComplaintModel.fromSnapshot(snapshot);
    } else {
      return null;
    }
  }


  Future<ComplaintModel> getComplaintDetailsById(String id) async {
    print('Fetching user details for ID: $id');
    final snapshot = await _db.collection("Complaint").doc(id).get();
    final complaintData = ComplaintModel.fromSnapshot(snapshot);
    return complaintData;
  }

  Future<void> updateComplaintRecord(ComplaintModel complaint) async {
    await _db.collection("Complaint").doc(complaint.id).update(complaint.toJson());
  }

  deleteComplaint(String id) async {
    await _db.collection("Complaint").doc(id).delete();
  }

  //Reservation
  createReservation(ReservationModel reservation) async{
    await _db.collection("Reservation").add(reservation.toJson()).whenComplete(
          () => Get.snackbar("Success", "A Reservation has been created.",
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

  Future<List<ReservationModel>> allReservation() async {
    final snapshot = await _db.collection("Reservation").get();
    final reservationData = snapshot.docs.map((e) => ReservationModel.fromSnapshot(e)).toList();
    return reservationData;
  }

  //Payment
  createPayment(PaymentModel payment) async {
    try {
      await _db.collection("Payment").add(payment.toJson()).whenComplete(
            () => Get.snackbar("Success", "Your Receipt has been submitted.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green),
      );
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("Error creating payment: $error");
      // Handle the error as needed, such as showing an error message to the user.
    }
  }

  Future<List<PaymentModel>> allPayment() async {
    final snapshot = await _db.collection("Payment").get();
    final paymentData = snapshot.docs.map((e) => PaymentModel.fromSnapshot(e)).toList();
    return paymentData;
  }


  //Profile
  Future<UserModel> getUserDetails(String email) async {
    print('Fetching user details for email: $email');
    final snapshot = await _db.collection("User").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<UserModel> getUserDetailsById(String userId) async {
    print('Fetching user details for ID: $userId');
    final snapshot = await _db.collection("User").doc(userId).get();
    final userData = UserModel.fromSnapshot(snapshot);
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("User").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("User").doc(user.id).update(user.toJson());
  }

  deleteUser(String userId) async {
    await _db.collection("User").doc(userId).delete();
  }
}