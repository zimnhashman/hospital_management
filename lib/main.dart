import 'package:flutter/material.dart';
import 'package:hospital_management/screens/signup.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const GetMaterialApp(
    title: 'Eulita Hospital Management',
    home: SignUp()
  ));
}


