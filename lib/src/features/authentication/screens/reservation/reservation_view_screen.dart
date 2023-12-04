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

class ReservationViewScreen extends StatelessWidget {
  final ReservationModel reservation;

  const ReservationViewScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationController());

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
                  Row(
                    children: [
                      Text('Status: ${reservation.status}'),
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
