import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ComplaintModel {
  final String? id;
  final String title;
  final String location;
  final String description;
  final DateTime dateTime; // Change the type to DateTime
  final String status;
  final String? imageURL;
  final String userEmail;

  ComplaintModel({
    this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.dateTime, // Update the type to DateTime
    required this.status,
    this.imageURL,
    required this.userEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      "TitleChoice": title,
      "Location": location,
      "Description": description,
      "DateTime": DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime),
      "Status": status,
      "ImageURL": imageURL,
      "UserEmail": userEmail,
    };
  }

  factory ComplaintModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ComplaintModel(
      id: document.id,
      title: data["TitleChoice"] ?? "",
      location: data["Location"] ?? "",
      description: data["Description"] ?? "",
      dateTime: _parseDateTime(data["DateTime"]),
      status: data["Status"] ?? "",
      imageURL: data["ImageURL"] ?? "",
      userEmail: data["UserEmail"] ?? "",
    );
  }

  static DateTime _parseDateTime(String dateString) {
    try {
      return DateTime.parse(dateString ?? "");
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }
}
