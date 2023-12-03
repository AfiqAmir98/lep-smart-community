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

class UpdatePaymentScreen extends StatelessWidget {
  final PaymentModel payment;

  const UpdatePaymentScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    final status = TextEditingController(text: payment.status);
    final id = TextEditingController(text: payment.id);

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

                  TextFormField(
                    controller: status,
                    decoration: const InputDecoration(
                        label: Text('Status'), prefixIcon: Icon(LineAwesomeIcons.save)),
                  ),
                  const SizedBox(height: tFormHeight - 20),

                  // -- Form Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Update the complaint status and submit the form
                        final updatedComplaint = PaymentModel(
                          id: id.text.trim(),
                          userEmail: payment.userEmail,
                          dateTime: payment.dateTime,
                          status: status.text.trim(),
                          imageURL: payment.imageURL,
                        );
                        await controller.updatePayment(updatedComplaint);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Submit', style: TextStyle(color: tDarkColor)),
                    ),
                  ),

                  // -- Created Date and Delete Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Check if the complaint id is not null before calling deleteComplaint
                          if (payment.id != null) {
                            await controller.deletePayment(payment.id!);
                          } else {
                            // Handle the case where the complaint id is null (optional)
                            print('Payment id is null. Unable to delete.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.1),
                          elevation: 0,
                          foregroundColor: Colors.red,
                          shape: const StadiumBorder(),
                          side: BorderSide.none,
                        ),
                        child: const Text(tDelete),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
