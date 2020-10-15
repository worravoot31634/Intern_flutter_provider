import 'dart:developer';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/provider/late_checkin_provider.dart';

class LateCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LateCheckIn(),
    );
  }
}

class _LateCheckIn extends StatelessWidget {

  // String _date = "Not set";
  // String _time = "Not set";
  // DateTime _firstDateSelect = DateTime(
  //   DateTime.now().year,
  //   1,
  //   1,
  // );
  // DateTime _lastDateSelect = DateTime(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day, 23, 59, 59);
  // DateTime _initialDate = DateTime.now();

  // @override
  // void initState() {
  //   _time = DateFormat("HH:mm").format(DateTime.now());
  //   _date = DateFormat("d MMM yyyy").format(DateTime.now());
  //   super.initState();
  // }

  //TimeOfDay timeSelect = TimeOfDay.now();

  // void onTimeChanged(TimeOfDay newTime) {
  //   setState(() {
  //     timeSelect = newTime;
  //     final now = new DateTime.now();
  //     DateTime time =
  //         DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
  //     _time = DateFormat("HH:mm").format(time);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    log('Build at ' + DateTime.now().toString(), name: '[LateCheckIn screen]');
    return Consumer<LateCheckInProvider>(
        builder: (BuildContext context, states, Widget child) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "Cube SoftTech",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'ubuntu',
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          "assets/images/notification.png",
                          height: 22,
                        ),
                        SizedBox(width: 16),
                        Image.asset(
                          "assets/images/menu.png",
                          height: 22,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/clock_black.png",
                          height: 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            "Late Check In",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'avenir'),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Choose Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Choose Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          child: Center(
                            child: RaisedButton(
                              onPressed: () async {
                                _showDatePicker(context, states);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xff29404E),
                              /*Color.fromRGBO(15, 129, 68, 1),*/
                              child: Center(
                                child: Text(
                                  states.date,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 80,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).push(
                                showPicker(
                                  context: context,
                                  borderRadius: 16,
                                  value: states.defaultTime,
                                  is24HrFormat: true,
                                  onChange: states.onTimeChanged,
                                  // onChangeDateTime: (DateTime dateTime) {
                                  //   print(dateTime);
                                  // },
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Color(0xff29404E),
                            /*Color.fromRGBO(15, 76, 129, 1),*/
                            child: Container(
                              child: Text(
                                states.time,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 22.0, color: Colors.red),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Description",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        // controller: _ctrlUsername,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: 80,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromRGBO(15, 76, 129, 1),
                    //           Color.fromRGBO(15, 76, 129, .9),
                    //           Color.fromRGBO(15, 76, 129, .5),
                    //         ],
                    //       ),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         _time,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 40,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _showDatePicker(BuildContext context, LateCheckInProvider states) {
    return showRoundedDatePicker(
      context: context,
      height: MediaQuery.of(context).size.height * 0.3,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(15, 129, 68, 1),
        accentColor: Color.fromRGBO(15, 129, 68, 1),
      ),
      onTapDay: (DateTime dateTime, bool available) {
        print("return $available");
        if (available == true) {
          states.onDateChanged(dateTime);
          // setState(() {
            // _date = DateFormat("dd MMM yyyy").format(dateTime);
            // _initialDate = dateTime;
          // });
          Navigator.of(context, rootNavigator: true).pop();
        }
        return available;
      },
      textPositiveButton: "CANCEL",
      textNegativeButton: "",
      initialDate: states.defaultDate,
      firstDate: states.firstDateSelectable,
      lastDate: states.lastDateSelectable,
      //yyyy-mm-dd
      borderRadius: 16,
    );
    //log(newDateTime.toString());
  }
}

// class CustomPicker extends CommonPickerModel {
//   String digits(int value, int length) {
//     return '$value'.padLeft(length, "0");
//   }
//
//   CustomPicker({DateTime currentTime, LocaleType locale})
//       : super(locale: locale) {
//     this.currentTime = currentTime ?? DateTime.now();
//     this.setLeftIndex(this.currentTime.hour);
//     this.setMiddleIndex(this.currentTime.minute);
//     this.setRightIndex(this.currentTime.second);
//   }
//
//   @override
//   String leftStringAtIndex(int index) {
//     if (index >= 0 && index < 24) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String middleStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String rightStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String leftDivider() {
//     return "";
//   }
//
//   @override
//   String rightDivider() {
//     return ":";
//   }
//
//   @override
//   List<int> layoutProportions() {
//     return [1, 1, 0];
//   }
//
//   @override
//   DateTime finalTime() {
//     return currentTime.isUtc
//         ? DateTime.utc(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex())
//         : DateTime(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex());
//   }
// }
