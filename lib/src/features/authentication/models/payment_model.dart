import 'package:intl/intl.dart';

class PaymentModel {
  final String? id;
  final String? imageURL;
  final DateTime dateTime; // Change the type to DateTime
  final String status;

  PaymentModel({
    this.id,
    required this.imageURL,
    required this.dateTime, // Change the parameter type to DateTime
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "ImageURL": imageURL,
      "DateTime": DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime), // Format DateTime to String here in JSON output
      "Status": status,
    };
  }
}
