import 'package:flutter/material.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:psm_project/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:psm_project/src/features/authentication/screens/login/login_footer_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LogInFormWidget(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}