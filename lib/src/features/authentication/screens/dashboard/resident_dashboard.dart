import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/complaint.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/complaint_button.dart';
import 'package:psm_project/src/features/authentication/screens/signup/sign_up.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/dashboard_controller.dart';
import '../complaint/list_complaint_screen.dart';
import '../payment/payment.dart';
import '../profile/profile_screen.dart';
import '../reservation/reservation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DashboardController _dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize data, including user role
  Future<void> _initializeData() async {
    await _dashboardController.getUserData();
    // You can add additional initialization steps here if needed
    print("User Role: ${_dashboardController.userRole.value}");
    // Force a re-build to check if the visibility updates
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("User Role (Build Method): ${_dashboardController.userRole.value}");

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
                  title: Obx(() {
                    String greeting = 'Hello Resident!';

                    // Check user role and customize greeting
                    if (DashboardController.instance.userRole.value == 'admin') {
                      greeting = 'Hello Admin!';
                    } else if (DashboardController.instance.userRole.value == 'maintenance') {
                      greeting = 'Hello Maintenance!';
                    }
                    // Add more conditions as needed for other roles

                    return Text(greeting, style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ));
                  }),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white54,
                      )),
                    ],
                  ),
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
                  IconButton(onPressed: () => Get.to(() => const ComplaintScreen()), icon: const Image(image: AssetImage(tReport)),),
                  IconButton(onPressed: () => Get.to(() => const ReservationScreen()), icon: const Image(image: AssetImage(tBooking))),
                  IconButton(onPressed: () => Get.to(() => const PaymentScreen()), icon: const Image(image: AssetImage(tPayment))),
                  Visibility(
                    // Use the Visibility widget to conditionally hide the button
                    visible: _dashboardController.userRole.value == 'admin' ||
                        _dashboardController.userRole.value == 'maintenance',
                    child: IconButton(
                      onPressed: () => Get.to(() => const ComplaintListScreen()),
                      icon: const Image(image: AssetImage(tComplaint)),
                    ),
                  ),
                  Visibility(
                    // Use the Visibility widget to conditionally hide the button
                    visible: _dashboardController.userRole.value == 'admin',
                    child: IconButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      icon: const Image(image: AssetImage(tRegister)),
                    ),
                  ),
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