import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_management/screens/doctor/view_appointments.dart';
import 'package:hospital_management/screens/doctor/view_patients.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 12.0),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.account_circle_outlined, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('View Patients', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              onTap: () => {
                Get.to(const ViewPatientsScreen())
              },
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.contact_mail_sharp, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('View Appointments', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              onTap: () => {
                Get.to(const ViewAppointments())
              },
            ),
          ]
        ),
      ),
    );
  }
}
