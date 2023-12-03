import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/constants/image_strings.dart';
import 'package:psm_project/src/features/authentication/screens/profile/list_profile_screen.dart';
import 'package:psm_project/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:psm_project/src/features/authentication/screens/profile/widget/profile_menu.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../controllers/dashboard_controller.dart';
import '../complaint/list_complaint_screen.dart';
import '../payment/list_payment_screen.dart';
import '../reservation/list_reservation_screen.dart';
import '../reservation/reservation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final DashboardController _dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize data, including user role
  Future<void> _initializeData() async {
    await _dashboardController.getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tProfile, style: Theme.of(context).textTheme.headline4),
        actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage(tUserProfileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(tProfileHeading, style: Theme.of(context).textTheme.headline4),
              Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- MENU
              Visibility(
                // Use the Visibility widget to conditionally hide the button
                visible: _dashboardController.userRole.value == 'admin' ||
                    _dashboardController.userRole.value == 'maintenance',
                child: ProfileMenuWidget(title: "Reports", icon: LineAwesomeIcons.list, onPress: () => Get.to(() => const ComplaintListScreen()),),
              ),
              Visibility(
                // Use the Visibility widget to conditionally hide the button
                visible: _dashboardController.userRole.value == 'admin',
                child: ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () => Get.to(() => const PaymentListScreen()),),
              ),
              Visibility(
                // Use the Visibility widget to conditionally hide the button
                visible: _dashboardController.userRole.value == 'admin',
                child: ProfileMenuWidget(title: "Reservation", icon: LineAwesomeIcons.calendar, onPress: () => Get.to(() => const ReservationListScreen()),),
              ),
              Visibility(
                // Use the Visibility widget to conditionally hide the button
                visible: _dashboardController.userRole.value == 'admin',
                child: ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () => Get.to(() => const ProfileListScreen()),),
              ),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => AuthenticationRepository.instance.logout(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}