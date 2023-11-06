import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/models/complaint_model.dart';
import '../../controllers/complaint_controller.dart';


class ComplaintFormWidget extends StatefulWidget {
  const ComplaintFormWidget({Key? key}) : super(key: key);

  @override
  _ComplaintWidgetState createState() => _ComplaintWidgetState();
}

class _ComplaintWidgetState extends State<ComplaintFormWidget> {
  final controller = Get.put(ComplaintController());
  final _formKey = GlobalKey<FormState>();
  XFile? _image;

  TitleChoice selectedTitleChoice = TitleChoice.Road; // Default role is road

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
            DropdownButtonFormField<TitleChoice>(
              value: selectedTitleChoice,
              onChanged: (TitleChoice? newValue) {
                setState(() {
                  selectedTitleChoice = newValue!;
                });
              },
              items: TitleChoice.values.map<DropdownMenuItem<TitleChoice>>((TitleChoice title) {
                return DropdownMenuItem<TitleChoice>(
                  value: title,
                  child: Text(title.toString().split('.').last), // Converts enum value to string
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            TextFormField(
              controller: controller.location,
              decoration: const InputDecoration(
                  label: Text(tLocation),
                  prefixIcon: Icon(Icons.location_city_rounded)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.description,
              decoration: const InputDecoration(
                  label: Text(tDescription),
                  prefixIcon: Icon(Icons.text_fields_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20),
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
                    final complaint = ComplaintModel(
                      location: controller.location.text.trim(),
                      description: controller.description.text.trim(),
                      title: selectedTitleChoice.toString().split('.').last, // Convert enum to String
                      dateTime: DateTime.now(),
                      status: 'in progress',
                      imageURL: _image!.path, // Store the image path in the model
                    );
                    ComplaintController.instance.createComplaint(complaint);
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