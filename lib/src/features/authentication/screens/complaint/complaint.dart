import 'package:flutter/material.dart';
import 'package:psm_project/src/constants/image_strings.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/screens/complaint/complaint_form_widget.dart';

import 'complaint_header_widget.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                ComplaintHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tComplaintHeader,
                  subTitle: tSignUpSubtitle,
                  imageHeight: 0.15,
                ),
                ComplaintFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}