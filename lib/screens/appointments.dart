import 'package:flutter/material.dart';
import 'package:hospital_management/database/database_helper.dart';
import 'package:hospital_management/screens/add_appointment_screen.dart';

class ViewAllAppointmentsScreen extends StatefulWidget {
  const ViewAllAppointmentsScreen({super.key});

  @override
  _ViewAllAppointmentsScreenState createState() =>
      _ViewAllAppointmentsScreenState();
}

class _ViewAllAppointmentsScreenState extends State<ViewAllAppointmentsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _appointments = [];
  String selectedOption = 'Prescriptions';

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    List<Map<String, dynamic>> appointments =
        await _databaseHelper.getAppointments();
    setState(() {
      _appointments = appointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Appointments'),
        ),
        body: _appointments.isEmpty
            ? const Center(
                child: Text('No appointments available.'),
              )
            : Column(
                children: [
                  const Text('Select View Per Appointment'),
                  Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RadioListTile<String>(
                          title: const Text('View Prescriptions'),
                          value: 'Prescriptions',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('View Lab Reports'),
                          value: 'Lab Reports',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('View Lab Tests'),
                          value: 'Lab Tests',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    itemCount: _appointments.length,
                    itemBuilder: (context, index) {
                      return Column(

                        children: [
                          ListTile(
                            title: Text(_appointments[index]['appointment_title']),
                            subtitle: Text(
                                'Date: ${_appointments[index]['appointment_date']}'),
                            trailing: Text(
                              _appointments[index]['appointment_complete'] == 1
                                  ? 'Complete'
                                  : 'Incomplete',
                            ),
                            onTap: () {
                              // Navigate to ViewLabReportsScreen, ViewLabTestsScreen, or ViewPrescriptionsScreen with the selected appointmentId
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewPrescriptionsScreen(
                                    appointmentId: _appointments[index]['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),

                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to AddAppointmentScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAppointmentScreen()),
            ).then((value) {
              // Refresh the list when returning from AddAppointmentScreen
              _loadAppointments();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ViewLabReportsScreen extends StatefulWidget {
  final int appointmentId;

  const ViewLabReportsScreen({super.key, required this.appointmentId});

  @override
  _ViewLabReportsScreenState createState() => _ViewLabReportsScreenState();
}

class _ViewLabReportsScreenState extends State<ViewLabReportsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _labReports = [];

  @override
  void initState() {
    super.initState();
    _loadLabReports();
  }

  Future<void> _loadLabReports() async {
    List<Map<String, dynamic>> labReports =
        await _databaseHelper.getLabReports(widget.appointmentId);
    setState(() {
      _labReports = labReports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Reports'),
      ),
      body: _labReports.isEmpty
          ? const Center(
              child: Text('No lab reports available for this appointment.'),
            )
          : ListView.builder(
              itemCount: _labReports.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_labReports[index]['report_name']),
                  subtitle: Text('Date: ${_labReports[index]['date']}'),
                  trailing: Text('Result: ${_labReports[index]['result']}'),
                );
              },
            ),
    );
  }
}

class ViewLabTestsScreen extends StatefulWidget {
  final int appointmentId;

  const ViewLabTestsScreen({super.key, required this.appointmentId});

  @override
  _ViewLabTestsScreenState createState() => _ViewLabTestsScreenState();
}

class _ViewLabTestsScreenState extends State<ViewLabTestsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _labTests = [];

  @override
  void initState() {
    super.initState();
    _loadLabTests();
  }

  Future<void> _loadLabTests() async {
    List<Map<String, dynamic>> labTests =
        await _databaseHelper.getLabTests(widget.appointmentId);
    setState(() {
      _labTests = labTests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Tests'),
      ),
      body: _labTests.isEmpty
          ? const Center(
              child: Text('No lab tests available for this appointment.'),
            )
          : ListView.builder(
              itemCount: _labTests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_labTests[index]['test_name']),
                  subtitle: Text('Date: ${_labTests[index]['date']}'),
                  trailing: Text('Result: ${_labTests[index]['result']}'),
                );
              },
            ),
    );
  }
}

class ViewPrescriptionsScreen extends StatefulWidget {
  final int appointmentId;

  const ViewPrescriptionsScreen({super.key, required this.appointmentId});

  @override
  _ViewPrescriptionsScreenState createState() =>
      _ViewPrescriptionsScreenState();
}

class _ViewPrescriptionsScreenState extends State<ViewPrescriptionsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _prescriptions = [];

  @override
  void initState() {
    super.initState();
    _loadPrescriptions();
  }

  Future<void> _loadPrescriptions() async {
    List<Map<String, dynamic>> prescriptions =
        await _databaseHelper.getPrescriptions(widget.appointmentId);
    setState(() {
      _prescriptions = prescriptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions'),
      ),
      body: _prescriptions.isEmpty
          ? const Center(
              child: Text('No prescriptions available for this appointment.'),
            )
          : ListView.builder(
              itemCount: _prescriptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_prescriptions[index]['medicine_name']),
                  subtitle: Text('Dosage: ${_prescriptions[index]['dosage']}'),
                  trailing: Text('Date: ${_prescriptions[index]['date']}'),
                );
              },
            ),
    );
  }
}
