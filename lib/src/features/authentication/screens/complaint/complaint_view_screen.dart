import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../models/complaint_model.dart';

class ComplaintViewScreen extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintViewScreen({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Complaint Form', style: Theme.of(context).textTheme.headline4),
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
                      child: complaint.imageURL != null && complaint.imageURL!.startsWith('http')
                          ? Image.network(complaint.imageURL!, fit: BoxFit.cover)
                          : Image.file(File(complaint.imageURL!), fit: BoxFit.cover),
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
                      Text('Title: ${complaint.title}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Location: ${complaint.location}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Description: ${complaint.description}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Date and Time: ${complaint.dateTime.toString()}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('User Email: ${complaint.userEmail}'),
                    ],
                  ),
                  const SizedBox(height: tFormHeight - 20),
                  Row(
                    children: [
                      Text('Status: ${complaint.status}'),
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
