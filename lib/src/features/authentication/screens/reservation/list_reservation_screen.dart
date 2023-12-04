import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/controllers/profile_controller.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/update_complaint_screen.dart';
import 'package:psm_project/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:psm_project/src/features/authentication/screens/reservation/update_reservation_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/reservation_controller.dart';
import '../../models/complaint_model.dart';
import '../../models/reservation_model.dart';

class ReservationListScreen extends StatelessWidget {
  const ReservationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Reservation List', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder<List<ReservationModel>>(
              future: controller.getAllReservation(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (c, index){
                          // Wrap ListTile with GestureDetector
                          return GestureDetector(
                              onTap: () async {
                                // Fetch the detailed user data based on the selected user's ID
                                ReservationModel detailedReservation = await controller.getReservationDetailsById(snapshot.data![index].id!);

                                // Navigate to the UpdateProfileScreen with the fetched user data
                                Get.to(() => UpdateReservationScreen(reservation: detailedReservation));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    iconColor: Colors.blue,
                                    tileColor: Colors.blue.withOpacity(0.1),
                                    leading: const Icon(LineAwesomeIcons.comment),
                                    title: Text("Location: ${snapshot.data![index].location}"),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].status,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16, // Set the desired font size
                                          ),
                                        ),
                                        Text(DateFormat('dd-MM-yyyy HH:mm:ss').format(snapshot.data![index].dateTime)),
                                        Text(snapshot.data![index].userEmail),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              )
                          );
                        }
                    );
                  } else if (snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  } else{
                    return const Center(child: Text('Something went wrong'));
                  }
                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              }
          ),
        ),
      ),
    );
  }
}