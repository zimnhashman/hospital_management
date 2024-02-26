import 'package:flutter/material.dart';
import 'package:hospital_management/database/database_helper.dart';


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
    List<Map<String, dynamic>> labReports = await _databaseHelper.getLabReports(widget.appointmentId);
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
