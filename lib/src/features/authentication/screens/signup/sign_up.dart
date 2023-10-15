import 'package:flutter/material.dart';
import 'package:psm_project/src/constants/image_strings.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/screens/signup/form_header_widget.dart';
import 'package:psm_project/src/features/authentication/screens/signup/sign_form_widget.dart';
import 'package:psm_project/src/features/authentication/screens/signup/signup_footer_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubtitle,
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}