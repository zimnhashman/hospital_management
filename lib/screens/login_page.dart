import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_management/constants/colors.dart';
import 'package:hospital_management/screens/signup.dart';
import 'package:hospital_management/widgets/mybutton.dart';
import 'package:hospital_management/widgets/mytextfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  bool _loading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: _loading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                            // SvgPicture.asset(
                            //   login_image,
                            //   height: MediaQuery.of(context).size.height * 0.35,
                            // ),
                            SizedBox(height: 20),

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

                              },
                              child: MyButton(
                                text: 'LOGIN',
                                btnColor: primaryColor,
                                btnRadius: 8,
                              ),
                            ),

                            // link to sign up page
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SignUp()));
                                  },
                                  child: Text(
                                    'Sign up',
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
      ),
    );
  }
}
