import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ReservationModel {
  final String? id;
  final String location;
  final String description;
  final String dateTime;
  final String status;
  final String userEmail;

  ReservationModel({
    this.id,
    required this.location,
    required this.description,
    required DateTime dateTime,
    required this.status,
    required this.userEmail,
  }) : dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime); // Format DateTime to String here;

  Map<String, dynamic> toJson() {
    return {
      "Location": location,
      "Description": description,
      "DateTime": dateTime, // Include formatted date in JSON output
      "Status": status,
      "UserEmail": userEmail,
    };
  }
}