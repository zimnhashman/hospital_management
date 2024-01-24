import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_management/constants/colors.dart';
import 'package:hospital_management/widgets/mytextfield.dart';

class LabTests extends StatefulWidget {
  final String userId;

  LabTests({ required this.userId });

  @override
  _LabTestsState createState() => _LabTestsState();
}

class _LabTestsState extends State<LabTests> {
  bool _loading = false;
  late List _labTests;
  late double width;
  late double height;
  String dropdownValue = 'Update';

  TextEditingController _detailsController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Lab Tests'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Lab Test'),
        onPressed: () {
          _addNewLabTestDialog(context);
        },
        icon: Icon(Icons.science_outlined),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
        height: height,
        child: _labTests.length > 0
            ? SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {
             // _getLabTests();
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: height * 0.85,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _labTests.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 6),
                      margin:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorWhite,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Lab Test ID: ',
                                    style:
                                    DefaultTextStyle.of(context)
                                        .style,
                                    children: [
                                      TextSpan(
                                        text: _labTests[index]
                                        ['test_id']
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                    ]),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: _labTests[index]
                                    ['test_status'] ==
                                        'ACCEPTED'
                                        ? Colors.green
                                        : _labTests[index][
                                    'test_status'] ==
                                        'PAID'
                                        ? Colors.blue[700]
                                        : _labTests[index][
                                    'test_status'] ==
                                        'COMPLETED'
                                        ? Colors.grey[600]
                                        : Colors.redAccent[
                                    100]),
                                child: Text(
                                  _labTests[index]['test_status'],
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: width - 80,
                                height: 50,
                                child: Text(
                                  _labTests[index]['details'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Appointment: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              _labTests[index]['date'] == null
                                  ? Text(
                                'N/A',
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w500),
                              )
                                  : Text(
                                _labTests[index]['date'],
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        )
            : Center(
          child: Text('No lab tests found!'),
        ),
      ),
    );
  }

// add new lab test dialog
  Future _addNewLabTestDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    height: 70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('New Lab Test',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: colorWhite),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          MyTextField(
                            hint: 'Details',
                            icon: Icons.note,
                            isMultiline: true,
                            maxLines: 5,
                            controller: _detailsController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'Details are required';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);

                                // _makePayment().then((value) {
                                //   if (value.success == true) {
                                //     _addLabTest(value.paymentId).then((val) {
                                //       var res = jsonDecode(val.body);
                                //
                                //       if (res['error'] == true) {
                                //         Fluttertoast.showToast(
                                //             msg: res['message'],
                                //             backgroundColor: Colors.red[600],
                                //             textColor: colorWhite,
                                //             toastLength: Toast.LENGTH_LONG);
                                //       } else {
                                //         Fluttertoast.showToast(
                                //             msg: res['message'],
                                //             backgroundColor: Colors.green,
                                //             textColor: colorWhite,
                                //             toastLength: Toast.LENGTH_LONG)
                                //             .then((value) {
                                //           setState(() {
                                //             _detailsController.clear();
                                //           });
                                //           _getLabTests();
                                //         });
                                //       }
                                //     });
                                //   } else {
                                //     Fluttertoast.showToast(
                                //         msg: value.message,
                                //         backgroundColor: Colors.red[600],
                                //         textColor: colorWhite,
                                //         toastLength: Toast.LENGTH_LONG);
                                //   }
                                // });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.0,
                              width: double.infinity,
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }}
