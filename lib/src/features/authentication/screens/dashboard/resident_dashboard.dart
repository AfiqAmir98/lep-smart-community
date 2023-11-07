import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/complaint.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
import '../payment/payment.dart';
import '../profile/profile_screen.dart';
import '../reservation/reservation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black,),
        title: Text(tAppName, style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: tCardBgColor),
            child: IconButton(onPressed: () => Get.to(() => const ProfileScreen()), icon: const Image(image: AssetImage(tUserProfileImage))),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/lep-welcome.png', // Replace this with the path to your image asset
                  height: 450, // Set the height of the image as per your requirement
                  width: 450, // Set the width of the image as per your requirement
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Resident!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Welcome Back', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50,
                children: [
                  IconButton(onPressed: () => Get.to(() => const ComplaintScreen()), icon: const Image(image: AssetImage(tReport))),
                  IconButton(onPressed: () => Get.to(() => const ReservationScreen()), icon: const Image(image: AssetImage(tBooking))),
                  IconButton(onPressed: () => Get.to(() => const PaymentScreen()), icon: const Image(image: AssetImage(tPayment))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
