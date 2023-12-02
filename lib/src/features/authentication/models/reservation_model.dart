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

  factory ReservationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReservationModel(
      id: document.id,
      location: data["Location"] ?? "",
      description: data["Description"] ?? "",
      dateTime: _parseDateTime(data["DateTime"]),
      status: data["Status"] ?? "",
      userEmail: data["UserEmail"] ?? "",
    );
  }

  static DateTime _parseDateTime(String dateString) {
    try {
      return DateTime.parse(dateString ?? ""); // Handle null or empty date string
    } catch (e) {
      // Handle the parsing error, you might want to return a default value or throw an exception.
      print("Error parsing date: $e");
      return DateTime.now(); // Default value, you can adjust this as needed.
    }
  }
}