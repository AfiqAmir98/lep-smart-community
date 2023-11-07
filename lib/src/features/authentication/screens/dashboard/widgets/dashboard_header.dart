import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psm_project/src/constants/image_strings.dart';
import 'package:psm_project/src/constants/text_strings.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(tWelcomeScreenImage),
            height: size.height * 0.2),
      ],
    );
  }
}