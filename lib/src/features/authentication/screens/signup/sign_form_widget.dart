import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/controllers/signup_controller.dart';
import 'package:psm_project/src/features/authentication/models/user_model.dart';


class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  UserRole selectedUserRole = UserRole.admin; // Default role is admin

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.address,
              decoration: const InputDecoration(
                  label: Text(tAddress),
                  prefixIcon: Icon(Icons.house_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.icNo,
              decoration: const InputDecoration(
                  label: Text(tIcNumber),
                  prefixIcon: Icon(Icons.credit_card)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                  label: Text(tPhoneNo), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: tFormHeight - 20),
            DropdownButtonFormField<UserRole>(
              value: selectedUserRole,
              onChanged: (UserRole? newValue) {
                setState(() {
                  selectedUserRole = newValue!;
                });
              },
              items: UserRole.values.map<DropdownMenuItem<UserRole>>((UserRole role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(role.toString().split('.').last), // Converts enum value to string
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Role',
                prefixIcon: Icon(Icons.security),
              ),
            ),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text(tPassword), prefixIcon: Icon(Icons.fingerprint)),
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                      email: controller.email.text.trim(),
                      password: controller.password.text.trim(),
                      fullName: controller.fullName.text.trim(),
                      phoneNo: controller.phoneNo.text.trim(),
                      address: controller.address.text.trim(),
                      icNo: controller.icNo.text.trim(),
                      role: selectedUserRole.toString().split('.').last, // Convert enum to String
                    );
                    SignUpController.instance.createUser(user, selectedUserRole);
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}