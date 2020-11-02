import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/action/holiday_action.dart';
import 'package:provider_flutter_application/animation/LoadingRippleAnimation.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:provider_flutter_application/provider/late_checkin_provider.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LateCheckInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LateCheckInScreen(),
    );
  }
}

class _LateCheckInScreen extends StatelessWidget {

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
                      headerApp(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/clock_black.png',
                            height: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              'Late Check In',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'avenir'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: AutoSizeText(
                                              'Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            height: 80,
                                            child: Center(
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  _showDatePicker(
                                                      context, states);
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                                color: Color(0xff29404E),
                                                /*Color.fromRGBO(15, 129, 68, 1),*/
                                                child: Center(
                                                  child: AutoSizeText(
                                                    states.date,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: AutoSizeText(
                                              "Time",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
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
                                                  onChange:
                                                      states.onTimeChanged,
                                                  // onChangeDateTime: (DateTime dateTime) {
                                                  //   print(dateTime);
                                                  // },
                                                ),
                                              );
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            color: Color(0xff29404E),
                                            /*Color.fromRGBO(15, 76, 129, 1),*/
                                            child: Container(
                                              child: AutoSizeText(
                                                states.time,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AutoSizeTextField(
                                    controller: states.ctrlDescription,
                                    onChanged: (value) =>
                                        states.onDescriptionChanged(value),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: '${states.labelTextDes}',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: states.textFieldDesColor,
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: states.textFieldDesColor,
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'ex. I thought checked in.',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (states.description.length >=
                                                10) {
                                              return alertCheck(context,
                                                      'Late Check-In', states)
                                                  .show();
                                            } else {
                                              showSimpleNotification(
                                                  Text(
                                                      'Please fill the description with more than 10 characters!'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  background: Colors.red);
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          color: Colors.green[800],
                                          /*Color.fromRGBO(15, 76, 129, 1),*/
                                          child: Container(
                                            child: AutoSizeText(
                                              'Check In',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (states.description.length >=
                                                10) {
                                              return alertCheck(context,
                                                      'Late Check-Out', states)
                                                  .show();
                                            } else {
                                              showSimpleNotification(
                                                  Text(
                                                      'Please fill the description with more than 10 characters!'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  background: Colors.red);
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          color: Colors.blue[800],
                                          child: Container(
                                            child: AutoSizeText(
                                              'Check Out',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ToggleSwitch(
                        initialLabelIndex: states.enableStatus,
                        labels: ['OFF', 'ON'],
                        onToggle: (index) {
                          states.changeEnableButton(index);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDatePicker(BuildContext context, LateCheckInProvider states) async {

    return showRoundedDatePicker(
      context: context,
      initialDate: states.virtualCurrentDate,
      firstDate: states.firstDateSelectable,
      lastDate: states.virtualCurrentDate,
      listDateDisabled: states.listDateDisabled,
      barrierDismissible: true,
      customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
      height: MediaQuery.of(context).size.height * 0.45,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(15, 129, 68, 1),
        accentColor: Color.fromRGBO(15, 129, 68, 1),
      ),
      // listDateDisabled: holidayList,
      onTapDay: (DateTime dateTime, bool available) {
        print('return $available');
        if (available == true) {
          states.onDateChanged(dateTime);
          Get.back();
        } else if (available == false) {
          showSimpleNotification(Text("You can't choose this day"),
              duration: Duration(seconds: 2), background: Colors.red);
        }
        return available;
      },
      textPositiveButton: 'CANCEL',
      textNegativeButton: '',
      borderRadius: 16,
    );
  }

  Alert alertCheck(
      BuildContext context, String typeCheck, LateCheckInProvider states) {
    log('[lat]: ${states.latitude}');
    log('[long]: ${states.longitude}');
    String checkInType;
    if (typeCheck == 'Late Check-In') {
      //case Late CheckIn
      checkInType = '1';
    } else if (typeCheck == 'Late Check-Out') {
      //case Late CheckOut
      checkInType = '2';
    } else {
      //Error something
      checkInType = '0';
    }

    return Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      content: Consumer<HomeProvider>(
        builder: (BuildContext context, states, Widget child) => Container(
          height: 200,
          child: ((states.latitude == null) && (states.longitude == null))
              ? new LoadingRipple()
              : GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(states.latitude ?? 0, states.longitude ?? 0),
                    zoom: 20,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    states.mapController.complete(controller);
                  },
                ),
        ),
      ),
      title: '$typeCheck',
      buttons: [
        DialogButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: Colors.grey,
          onPressed: () {
            Get.back();
            log('cancel');
          },
        ),
        DialogButton(
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: Colors.green,
          onPressed: () async {
            log('$typeCheck : yes');
            states.confirmLateCheckIn(context, checkInType);
          },
        ),
      ],
    );
  }
}
