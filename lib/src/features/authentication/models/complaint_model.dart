import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ComplaintModel {
  final String? id;
  final String title;
  final String location;
  final String description;
  final String dateTime;
  final String status;
  final String? imageURL;
  final String userEmail;
  final String? resultImage;

  ComplaintModel({
    this.id,
    required this.title,
    required this.location,
    required this.description,
    required DateTime dateTime,
    required this.status,
    this.imageURL,
    this.resultImage,
    required this.userEmail,
  }) : dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime); // Format DateTime to String here;

  Map<String, dynamic> toJson() {
    return {
      "TitleChoice": title,
      "Location": location,
      "Description": description,
      "DateTime": dateTime, // Include formatted date in JSON output
      "Status": status,
      "ImageURL": imageURL,
      "ResultImage": resultImage,
      "UserEmail": userEmail,
    };
  }

  factory ComplaintModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ComplaintModel(
      id: document.id,
      title: data["TitleChoice"] ?? "", // Handle null value here
      location: data["Location"] ?? "",
      description: data["Description"] ?? "",
      dateTime: _parseDateTime(data["DateTime"]),
      status: data["Status"] ?? "",
      imageURL: data["ImageURL"] ?? "",
      resultImage: data["ResultImage"] ?? "",
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