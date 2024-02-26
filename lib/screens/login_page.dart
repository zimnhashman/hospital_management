import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hospital_management/constants/colors.dart';
import 'package:hospital_management/screens/dashboard.dart';
import 'package:hospital_management/screens/doctor/doctor_dashboard.dart';
import 'package:hospital_management/screens/signup.dart';
import 'package:hospital_management/widgets/mybutton.dart';
import 'package:hospital_management/widgets/mytextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  final bool _loading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          // SvgPicture.asset(
                          //   login_image,
                          //   height: MediaQuery.of(context).size.height * 0.35,
                          // ),
                          const SizedBox(height: 20),

                          // username
                          MyTextField(
                            controller: _usernameController,
                            hint: "Username",
                            icon: Icons.person,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),

                          // password
                          MyTextField(
                            controller: _passwordController,
                            hint: "Password",
                            isPassword: true,
                            isSecure: true,
                            icon: Icons.lock,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                          ),

                          // login button
                          GestureDetector(
                            onTap: () {
                              if (_usernameController.text == 'dr.eulita' &&
                                  _passwordController.text == 'dante@123') {
                                void showSnackbar(BuildContext context) {
                                  final snackBar = SnackBar(
                                    content: Text('${_usernameController.text} logged in successfully'),
                                    duration: const Duration(seconds: 5), // Optional, default is 4 seconds
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },
                                    ),
                                  );
                                  // Show the snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }
                                showSnackbar(context);
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const DoctorDashboard()));
                              } else if (_usernameController.text ==
                                      'nhaniso' &&
                                  _passwordController.text == 'nhaniso') {
                                void showSnackbar(BuildContext context) {
                                  final snackBar = SnackBar(
                                    content: Text('${_usernameController.text} logged in successfully'),
                                    duration: const Duration(seconds: 5), // Optional, default is 4 seconds
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },
                                    ),
                                  );
                                  // Show the snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }
                                showSnackbar(context);
                                Get.to(() => Dashboard(
                                      name: _usernameController.text,
                                      userId: _usernameController.text,
                                    ));
                              } else {
                                void showSnackbar(BuildContext context) {
                                  final snackBar = SnackBar(
                                    content: const Text('Please Check Login Details!'),
                                    duration: const Duration(seconds: 5), // Optional, default is 4 seconds
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },
                                    ),
                                  );
                                  // Show the snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }
                                showSnackbar(context);
                              }
                            },
                            child: const MyButton(
                              text: 'LOGIN',
                              btnColor: primaryColor,
                              btnRadius: 8,
                            ),
                          ),

                          // link to sign up page
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have a patient account?',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const SignUp()));
                                },
                                child: const Text(
                                  'Sign up Patient',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}


