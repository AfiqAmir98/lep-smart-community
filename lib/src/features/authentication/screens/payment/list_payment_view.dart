import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/controllers/profile_controller.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/update_complaint_screen.dart';
import 'package:psm_project/src/features/authentication/screens/payment/payment_view_screen.dart';
import 'package:psm_project/src/features/authentication/screens/payment/update_payment_screen.dart';
import 'package:psm_project/src/features/authentication/screens/profile/update_profile_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../models/complaint_model.dart';
import '../../models/payment_model.dart';

class PaymentListViewScreen extends StatelessWidget {
  const PaymentListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Payment History', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder<List<PaymentModel>>(
              future: controller.allPayment(),
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
                                PaymentModel detailedPayment = await controller.getPaymentDetailsById(snapshot.data![index].id!);

                                // Navigate to the UpdateProfileScreen with the fetched user data
                                Get.to(() => PaymentViewScreen(payment: detailedPayment));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    iconColor: Colors.blue,
                                    tileColor: Colors.blue.withOpacity(0.1),
                                    leading: const Icon(LineAwesomeIcons.comment),
                                    title: Text("Status: ${snapshot.data![index].status}"),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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