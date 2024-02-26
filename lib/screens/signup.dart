import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:hospital_management/constants/colors.dart';
import 'package:hospital_management/database/patient_database.dart';
import 'package:hospital_management/screens/login_page.dart';
import 'package:hospital_management/widgets/custom_date_picker_form_field.dart';
import 'package:hospital_management/widgets/myButton.dart';
import 'package:hospital_management/widgets/myTextField.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late double width;
  late double height;
  bool visible = false;
  final bool _loading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    print('initState called');

  }


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
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Email address is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Mobile number is required';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  void _storeSignUpData() async {
    PatientDatabaseHelper dbHelper = PatientDatabaseHelper.instance;

    // Insert a new patient
    await dbHelper.insertPatient({
      'username': _usernameController.text,
      'email': _emailController.text,
      'name': _nameController.text,
      'contact': _contactController.text,
      'address': _addressController.text,
      'gender': _genderController.text,
      'password': _passwordController.text,
      'allergies': _allergiesController.text,
      'date_of_birth': _dateofbirthController.text,
    });

    // Retrieve patient details by username
    Map<String, dynamic>? patient = await dbHelper.getPatientByUsername('john_doe');
    print(patient);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'REGISTER',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    // SvgPicture.asset(
                    //   signup_image,
                    //   height: width * 0.50,
                    // ),
                    const SizedBox(height: 10),
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
                        _storeSignUpData;
                        // final SnackBar _snackBar = SnackBar(
                        //   content: b.get('email'),
                        //   duration: Duration(seconds: 5),);
                        // ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        Get.to(() => const LoginPage());
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
                        const Text(
                          'Already have an account?',
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
                                    builder: (_) => const LoginPage()));
                          },
                          child: const Text(
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
          child: child ?? const Text(''),
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
