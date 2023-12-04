import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../models/complaint_model.dart';
import '../../models/payment_model.dart';

class PaymentViewScreen extends StatelessWidget {
  final PaymentModel payment;
  const PaymentViewScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Payment Form', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 500,
                    height: 500,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)), // Adjust the radius as needed
                      child: payment.imageURL != null && payment.imageURL!.startsWith('http')
                          ? Image.network(payment.imageURL!, fit: BoxFit.cover)
                          : Image.file(File(payment.imageURL!), fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Column(
                children: [
                  // -- Text Widgets for Displaying Information
                  Row(
                    children: [
                      Text('Date and Time: ${payment.dateTime.toString()}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('User Email: ${payment.userEmail}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Status: ${payment.status}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
