import 'package:flutter/material.dart';
import 'package:hospital_management/database/database_helper.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _completeController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _completeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Complete (0 or 1)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _addAppointment();
              },
              child: const Text('Add Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void _addAppointment() async {
    String title = _titleController.text.trim();
    String date = _dateController.text.trim();
    int complete = int.tryParse(_completeController.text.trim()) ?? 0;

    if (title.isNotEmpty && date.isNotEmpty) {
      Map<String, dynamic> appointment = {
        'appointment_title': title,
        'appointment_date': date,
        'appointment_complete': complete,
      };

      int insertedId = await _databaseHelper.insertAppointment(appointment);

      if (insertedId != 0) {
        // Successful insertion
        _showSnackbar('Appointment added successfully!');
      } else {
        // Failed insertion
        _showSnackbar('Failed to add appointment.');
      }
    } else {
      _showSnackbar('Title and date are required fields.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }
}
