import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hospital_management/constants/colors.dart';
import 'package:hospital_management/screens/login_page.dart';
import 'package:hospital_management/widgets/custom_date_picker_form_field.dart';
import 'package:hospital_management/widgets/myButton.dart';
import 'package:hospital_management/widgets/myTextField.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {
  late double width;
  late double height;
  bool visible = false;
  bool _loading = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  DateTime? _dateOfBirth;

  var box = Hive.openBox("mybox");
  var b = Hive.box("mybox");


  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _dateofbirthController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _allergiesController.dispose();

    super.dispose();
  }



  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);

    if (value.isEmpty) {
      return 'Email address is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Mobile number is required';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    // SvgPicture.asset(
                    //   signup_image,
                    //   height: width * 0.50,
                    // ),
                    SizedBox(height: 10),
                    // full name
                    MyTextField(
                      controller: _nameController,
                      hint: "Name",
                      icon: Icons.account_box,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),

                    // username
                    MyTextField(
                      controller: _usernameController,
                      hint: "Username",
                      icon: Icons.account_box_rounded,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                    ),

                    // email
                    MyTextField(
                      controller: _emailController,
                      hint: "Email",
                      isEmail: true,
                      icon: Icons.contact_mail,
                      validation: (val) {
                        return validateEmail(val);
                      },
                    ),

                    // contact
                    MyTextField(
                      controller: _contactController,
                      hint: "Contact",
                      isNumber: true,
                      maxLength: 10,
                      icon: Icons.contact_phone,
                      validation: (val) {
                        return validateMobile(val);
                      },
                    ),

                    // address
                    MyTextField(
                      controller: _addressController,
                      hint: "Address",
                      isMultiline: true,
                      maxLines: 3,
                      icon: Icons.location_city,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Address is required";
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
                      icon: Icons.password,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),

                    // allergies
                    MyTextField(
                      controller: _allergiesController,
                      hint: "Allergies",
                      isMultiline: true,
                      maxLines: 2,
                      icon: Icons.location_city,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "none";
                        }
                        return null;
                      },
                    ),

                    // gender
                    MyTextField(
                      //todo: make boolean picker of gender or radio button
                      controller: _genderController,
                      hint: "Gender",
                      icon: Icons.person,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "none";
                        }
                        return null;
                      },
                    ),

                    // date of birth
                    CustomDatePickerFormField(
                        controller: _dateofbirthController,
                        txtLabel: 'Date of Birth',
                        callback: () => pickDateOfBirth(context)
                    ),

                    // bloodtype
                    MyTextField(
                      //todo: make drop down menu of bloodtypes
                      controller: _bloodTypeController,
                      hint: "Blood Type",
                      icon: Icons.water_drop_outlined,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "none";
                        }
                        return null;
                      },
                    ),


                    // login button
                    GestureDetector(
                      onTap: () {
                        b.put("username", _usernameController.text);
                        b.put("name", _nameController.text);
                        b.put("email", _emailController.text);
                        b.put("contact", _contactController.text);
                        b.put("address", _addressController.text);
                        b.put("gender", _genderController.text);
                        b.put("password", _passwordController.text);
                        b.put("allergies", _allergiesController.text);
                        b.put("dateOfBirth", _dateOfBirth);

                        // final entity = PatientCompanion(
                        //   userName: drift.Value(_usernameController.text),
                        //   name: drift.Value(_nameController.text),
                        //   email: drift.Value(_emailController.text),
                        //   contact: drift.Value(_contactController.text),
                        //   address: drift.Value(_addressController.text),
                        //   gender: drift.Value(_genderController.text),
                        //   password: drift.Value(_passwordController.text),
                        //   allergies: drift.Value(_allergiesController.text),
                        //   dateOfBirth: drift.Value(_dateOfBirth! as String),
                        // );

                       // _db.insertPatient(entity);
                        final SnackBar _snackBar = SnackBar(
                          content: b.get('email'),
                          duration: Duration(seconds: 5),);

                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                      },

                      child: MyButton(
                        text: 'SIGNUP',
                        btnColor: primaryColor,
                        btnRadius: 8,
                      ),
                    ),

                    // link to sign up page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
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
                                    builder: (_) => LoginPage()));
                          },
                          child: Text(
                            'Log in',
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


  // date picker
  Future<void> pickDateOfBirth(BuildContext  context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100), 
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            )
          ), 
          child: child ?? Text(''),
        )
    );
    
    if (newDate == null) {
      return;
    }  setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _dateofbirthController.text = dob;
    });
    
  }
}
