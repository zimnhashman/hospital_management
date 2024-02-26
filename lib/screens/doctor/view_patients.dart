import 'package:flutter/material.dart';
import 'package:hospital_management/database/patient_database.dart';
import 'package:hospital_management/screens/doctor/add_patients.dart';

class ViewPatientsScreen extends StatefulWidget {
  const ViewPatientsScreen({super.key});

  @override
  _ViewPatientsScreenState createState() => _ViewPatientsScreenState();
}

class _ViewPatientsScreenState extends State<ViewPatientsScreen> {
  final PatientDatabaseHelper _patientDatabaseHelper =
      PatientDatabaseHelper.instance;
  List<Map<String, dynamic>> _patients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    List<Map<String, dynamic>> patients =
        await _patientDatabaseHelper.getAllPatients();
    setState(() {
      _patients = patients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Patients'),
      ),
      body: _patients.isEmpty
          ? const Center(
              child: Text('No patients available.'),
            )
          : ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_patients[index]['name']),
                  subtitle: Text('Username: ${_patients[index]['username']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PatientDetailsScreen(patient: _patients[index]),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the "Add Patients" page
          bool success = Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPatientScreen()),
          ) as bool;

          // Refresh the patient list if a new patient was added successfully
          if (success == true) {
            _loadPatients();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${patient['name']}'),
            Text('Username: ${patient['username']}'),
            Text('Email: ${patient['email']}'),
            Text('Contact: ${patient['contact']}'),
            Text('Address: ${patient['address']}'),
            Text('Gender: ${patient['gender']}'),
            Text('Date of Birth: ${patient['date_of_birth']}'),
            Text('Allergies: ${patient['allergies']}'),
            // Add more patient details as needed
          ],
        ),
      ),
    );
  }
}
