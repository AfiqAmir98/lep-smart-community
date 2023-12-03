import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../models/complaint_model.dart';

class UpdateComplaintScreen extends StatelessWidget {
  final ComplaintModel complaint;

  const UpdateComplaintScreen({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintController());

    final status = TextEditingController(text: complaint.status);
    final id = TextEditingController(text: complaint.id);

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
                        final updatedComplaint = ComplaintModel(
                          id: id.text.trim(),
                          userEmail: complaint.userEmail,
                          title: complaint.title,
                          location: complaint.location,
                          dateTime: complaint.dateTime,
                          status: status.text.trim(),
                          imageURL: complaint.imageURL,
                          description: complaint.description,
                        );
                        await controller.updateComplaint(updatedComplaint);
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
                          if (complaint.id != null) {
                            await controller.deleteComplaint(complaint.id!);
                          } else {
                            // Handle the case where the complaint id is null (optional)
                            print('Complaint id is null. Unable to delete.');
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
