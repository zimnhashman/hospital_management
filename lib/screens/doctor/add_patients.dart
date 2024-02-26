import 'package:flutter/material.dart';
import 'package:hospital_management/database/patient_database.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // Add more controllers for other patient details as needed

  void _addPatient() async {
    Map<String, dynamic> newPatient = {
      'name': _nameController.text,
      'username': _usernameController.text,
      // Add more patient details here
    };

    // Call the database helper to insert the new patient
    int patientId = await PatientDatabaseHelper.instance.insertPatient(newPatient);

    if (patientId != -1) {
      // Patient added successfully, you can show a success message or navigate back
      Navigator.pop(context, true); // Navigate back to the previous screen with a success flag
    } else {
      // Handle error, e.g., show an error message
      print('Error adding patient');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            // Add more TextFields for other patient details as needed
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPatient,
              child: const Text('Add Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
