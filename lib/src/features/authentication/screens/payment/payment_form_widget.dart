import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import '../../controllers/payment_controller.dart';
import '../../models/payment_model.dart';
import '../success.dart';

class PaymentFormWidget extends StatefulWidget {
  const PaymentFormWidget({Key? key}) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentFormWidget> {
  final controller = Get.put(PaymentController());
  final _formKey = GlobalKey<FormState>();
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Image Upload Button
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text('Upload Receipt'),
            ),

            if (_image != null)
              Image.file(File(_image!.path)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    final userEmail = user.email;
                    final payment = PaymentModel(
                      dateTime: DateTime.now(),
                      status: 'pending',
                      imageURL: _image!.path,
                      userEmail: userEmail!,
                    );
                    PaymentController.instance.createPayment(payment);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(),
                      ),
                    );
                  } else {
                    // Handle the case when the user is not authenticated
                    print('User not authenticated');
                  }
                },
                child: Text(tSubmit.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
