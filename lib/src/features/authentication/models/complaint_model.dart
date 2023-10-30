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

  ComplaintModel({
    this.id,
    required this.title,
    required this.location,
    required this.description,
    required DateTime dateTime,
    required this.status,
  }) : dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime); // Format DateTime to String here;

  Map<String, dynamic> toJson() {
    return {
      "TitleChoice": title,
      "Location": location,
      "Description": description,
      "DateTime": dateTime, // Include formatted date in JSON output
      "Status": status,
    };
  }
}