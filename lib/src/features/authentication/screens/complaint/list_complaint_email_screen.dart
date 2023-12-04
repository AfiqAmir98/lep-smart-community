// ComplaintListScreen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/controllers/complaint_controller.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/update_complaint_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../models/complaint_model.dart';

class ComplaintListbyEmailScreen extends StatelessWidget {
  const ComplaintListbyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintController());
    User? user = AuthenticationRepository.instance.currentUser;
    String? userEmail = user?.email;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Complaint List', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder<List<ComplaintModel>>(
            future: controller.getAllComplaintbyEmail(userEmail ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return GestureDetector(
                        onTap: () async {
                          ComplaintModel detailedComplaint =
                          await controller.getComplaintDetailsById(snapshot.data![index].id!);
                          Get.to(() => UpdateComplaintScreen(complaint: detailedComplaint));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              iconColor: Colors.blue,
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: const Icon(LineAwesomeIcons.comment),
                              title: Text("Complaint: ${snapshot.data![index].title}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].status,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(DateFormat('dd-MM-yyyy HH:mm:ss').format(snapshot.data![index].dateTime)),
                                  Text(snapshot.data![index].userEmail),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
