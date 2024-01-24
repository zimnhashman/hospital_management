import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital_management/screens/login_page.dart';
import 'package:hospital_management/screens/signup.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter("myDatabase");

  runApp(GetMaterialApp(
    title: 'Eulita Hospital Management',
    home: SignUp()
  ));
}



