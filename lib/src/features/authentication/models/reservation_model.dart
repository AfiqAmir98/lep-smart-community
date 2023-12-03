import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ReservationModel {
  final String? id;
  final String location;
  final String description;
  final DateTime dateTime; // Change the type to DateTime
  final String status;
  final String userEmail;

  ReservationModel({
    this.id,
    required this.location,
    required this.description,
    required this.dateTime, // Update the type to DateTime
    required this.status,
    required this.userEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      "Location": location,
      "Description": description,
      "DateTime": DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime),
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