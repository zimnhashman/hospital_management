import 'package:flutter/material.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({super.key});

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: const Text('My Appointments')
          ),
          body: const Column()
      ),
    );
  }
}
