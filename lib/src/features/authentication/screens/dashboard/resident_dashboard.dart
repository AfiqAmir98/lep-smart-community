import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/complaint.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  clickableItemDashboard('Videos', LineAwesomeIcons.video, Colors.deepOrange),
                  clickableItemDashboard('Analytics', LineAwesomeIcons.pie_chart, Colors.green),
                  clickableItemDashboard('Audience', LineAwesomeIcons.users, Colors.purple),
                  clickableItemDashboard('Comments', LineAwesomeIcons.rocket_chat, Colors.brown),
                  clickableItemDashboard('Revenue', LineAwesomeIcons.money_bill, Colors.indigo),
                  clickableItemDashboard('Upload', LineAwesomeIcons.upload, Colors.teal),
                  clickableItemDashboard('About', LineAwesomeIcons.question, Colors.blue),
                  clickableItemDashboard('Contact', LineAwesomeIcons.phone, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  GestureDetector clickableItemDashboard(String title, IconData iconData, Color background) {
    return GestureDetector(
      onTap: () {
        // Handle button click here
        print('$title button clicked');
        // You can navigate to a new screen or perform any other action on button click
        Get.to(() => const ReservationScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

}
