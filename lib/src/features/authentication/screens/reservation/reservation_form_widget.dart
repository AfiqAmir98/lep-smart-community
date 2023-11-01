import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/constants/sizes.dart';
import 'package:psm_project/src/constants/text_strings.dart';
import 'package:psm_project/src/features/authentication/models/reservation_model.dart';
import '../../controllers/complaint_controller.dart';
import '../../controllers/reservation_controller.dart';

class ReservationFormWidget extends StatefulWidget {
  const ReservationFormWidget({Key? key}) : super(key: key);

  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationFormWidget> {
  final controller = Get.put(ReservationController());
  final _formKey = GlobalKey<FormState>();

  LocationChoice selectedLocationChoice = LocationChoice.Field; // Default role is road
  TextEditingController _dateTimeController = TextEditingController();

  @override
  void dispose() {
    _dateTimeController.dispose();
    super.dispose();
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
            DropdownButtonFormField<LocationChoice>(
              value: selectedLocationChoice,
              onChanged: (LocationChoice? newValue) {
                setState(() {
                  selectedLocationChoice = newValue!;
                });
              },
              items: LocationChoice.values.map<DropdownMenuItem<LocationChoice>>((LocationChoice location) {
                return DropdownMenuItem<LocationChoice>(
                  value: location,
                  child: Text(location.toString().split('.').last),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_city_rounded),
              ),
            ),
            TextFormField(
              controller: _dateTimeController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    DateTime selectedDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    _dateTimeController.text = selectedDateTime.toString();
                  }
                }
              },
              decoration: InputDecoration(
                labelText: tDateTime,
                prefixIcon: Icon(Icons.date_range_rounded),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.description,
              decoration: const InputDecoration(
                labelText: tDescription,
                prefixIcon: Icon(Icons.text_fields_outlined),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final reservation = ReservationModel(
                      description: controller.description.text.trim(),
                      location: selectedLocationChoice.toString().split('.').last,
                      dateTime: DateTime.parse(_dateTimeController.text),
                      status: 'in progress',
                    );
                    ReservationController.instance.createReservation(reservation);
                  }
                },
                child: Text(tSubmit.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
