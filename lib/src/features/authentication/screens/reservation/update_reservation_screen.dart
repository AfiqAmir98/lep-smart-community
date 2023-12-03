import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/reservation_controller.dart';
import '../../models/complaint_model.dart';
import '../../models/reservation_model.dart';

class UpdateReservationScreen extends StatelessWidget {
  final ReservationModel reservation;

  const UpdateReservationScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationController());

    final status = TextEditingController(text: reservation.status);
    final id = TextEditingController(text: reservation.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Reservation Form', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- Form Fields
              Column(
                children: [
                  // -- Text Widgets for Displaying Information
                  Row(
                    children: [
                      Text('Location: ${reservation.location}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Date and Time: ${reservation.dateTime.toString()}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('User Email: ${reservation.userEmail}'),
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
                        final updatedComplaint = ReservationModel(
                          id: id.text.trim(),
                          userEmail: reservation.userEmail,
                          location: reservation.location,
                          dateTime: reservation.dateTime,
                          status: status.text.trim(),
                          description: reservation.description,
                        );
                        await controller.updateReservation(updatedComplaint);
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
                          if (reservation.id != null) {
                            await controller.deleteReservation(reservation.id!);
                          } else {
                            // Handle the case where the complaint id is null (optional)
                            print('Reservation id is null. Unable to delete.');
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
