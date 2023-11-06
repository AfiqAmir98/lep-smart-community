import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import '../../controllers/payment_controller.dart';
import '../../models/payment_model.dart';

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
              child: Text('Pick Image'),
            ),

            if (_image != null)
              Image.file(File(_image!.path)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _image !=null) {
                    final payment = PaymentModel(
                      dateTime: DateTime.now(),
                      status: 'pending',
                      imageURL: _image!.path, // Store the image path in the model
                    );
                    PaymentController.instance.createPayment(payment);
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
