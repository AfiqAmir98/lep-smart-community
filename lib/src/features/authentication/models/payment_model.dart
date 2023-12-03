import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PaymentModel {
  final String? id;
  final String? imageURL;
  final DateTime dateTime; // Change the type to DateTime
  final String status;
  final String userEmail;

  PaymentModel({
    this.id,
    required this.imageURL,
    required this.dateTime, // Update the type to DateTime
    required this.status,
    required this.userEmail,
  }); // Format DateTime to String here;

  Map<String, dynamic> toJson() {
    return {
      "ImageURL": imageURL,
      "DateTime": DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime),
      "Status": status,
      "UserEmail": userEmail,
    };
  }

  factory PaymentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PaymentModel(
      id: document.id,
      dateTime: _parseDateTime(data["DateTime"]),
      status: data["Status"] ?? "",
      imageURL: data["ImageURL"] ?? "",
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
