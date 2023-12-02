import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UserModel user;
  const UpdateProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    final email = TextEditingController(text: user.email);
    final fullName = TextEditingController(text: user.fullName);
    final phoneNo = TextEditingController(text: user.phoneNo);
    final icNo = TextEditingController(text: user.icNo);
    final address = TextEditingController(text: user.address);
    final password = TextEditingController(text: user.password);
    final role = TextEditingController(text: user.role);
    final id = TextEditingController(text: user.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tEditProfile, style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(tUserProfileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                      child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullName,
                      decoration: const InputDecoration(
                          label: Text(tFullName), prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: address,
                      decoration: const InputDecoration(
                          label: Text(tEmail), prefixIcon: Icon(LineAwesomeIcons.home)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: icNo,
                      decoration: const InputDecoration(
                          label: Text(tIcNumber), prefixIcon: Icon(LineAwesomeIcons.alternate_identification_card)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: phoneNo,
                      decoration: const InputDecoration(
                          label: Text(tPhoneNo), prefixIcon: Icon(LineAwesomeIcons.phone)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          label: Text(tEmail), prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                          label: Text(tPassword), prefixIcon: Icon(LineAwesomeIcons.user_secret)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: role,
                      decoration: const InputDecoration(
                          label: Text(tEmail), prefixIcon: Icon(LineAwesomeIcons.user_1)),
                    ),
                    const SizedBox(height: tFormHeight - 20),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final updatedUser = UserModel(
                            id: id.text.trim(),
                            email: email.text.trim(),
                            fullName: fullName.text.trim(),
                            icNo: icNo.text.trim(),
                            phoneNo: phoneNo.text.trim(),
                            address: address.text.trim(),
                            role: role.text.trim(),
                            password: password.text.trim(),
                          );
                          await controller.updateRecord(updatedUser);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Call a function in the controller to handle the delete
                            await controller.deleteUser(id.text.trim());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                          ),
                          child: const Text(tDelete),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
