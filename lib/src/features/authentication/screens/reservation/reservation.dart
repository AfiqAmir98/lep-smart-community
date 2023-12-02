import 'package:flutter/material.dart';
import 'package:psm_project/src/constants/image_strings.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/screens/reservation/reservation_form_widget.dart';

import 'package:psm_project/src/features/authentication/screens/reservation/reservation_header.dart';


class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                ReservationHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tReservationHeader,
                  subTitle: tSignUpSubtitle,
                  imageHeight: 0.15,
                ),
                ReservationFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}