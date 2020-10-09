import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider_flutter_application/action/user_action.dart';
import 'package:provider_flutter_application/api/user_api/work_hours_api.dart';
import 'package:provider_flutter_application/model/work_hours.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';

class HomeProvider with ChangeNotifier {
  String _id;
  bool _statusCheckIn;
  double _latitude;
  double _longitude;
  String _nameStr;
  String _timeStr;
  String _dateStr;
  String _lastDateCheckInStr;
  String _ipAddress;
  String _userAgent;
  WorkHours _workHours;
  Timer _time;
  bool _initLoading;
  bool _latLongLoading = true;
  String _btnStatus;

  String get id => _id;

  bool get statusCheckIn => _statusCheckIn;

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get nameStr => _nameStr;

  String get timeStr => _timeStr;

  String get dateStr => _dateStr;

  String get lastDateCheckInStr => _lastDateCheckInStr;

  String get ipAddress => _ipAddress;

  String get userAgent => _userAgent;

  WorkHours get workHours => _workHours;

  Timer get time => _time;

  bool get initLoading => _initLoading;

  bool get latLongLoading => _latLongLoading;

  String get btnStatus => _btnStatus;

  //Declare
  LocationData currentLocation;
  UserAction userAction = new UserAction();
  WorkHoursApi workHourApi = new WorkHoursApi();

  HomeProvider() {
    log('Init',name: 'HomeProvider');

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if(_formatTime(DateTime.now()) != _timeStr){
        setDateTime();
      }
    });


    initState();
  }

  void initState() async {
    _initLoading = true;
    SharedPref pref = new SharedPref();
    currentLocation = await getCurrentLocation();

    _id = await pref.getId();
    _nameStr = await pref.getName();
    _latitude = currentLocation.latitude;
    _longitude = currentLocation.longitude;
    _dateStr = getCurrentDate();
    _timeStr = getCurrentTime();
    _ipAddress = await GetIp.ipAddress;
    _userAgent = await getUserAgent();
    updateButton();

    WorkHours workHours =
    await workHourApi.getLastCheckInById(await pref.getId());
    _lastDateCheckInStr = workHours.workHoursTimeWork;
    _initLoading = false; //disabled Home Screen loading
    notifyListeners();
  }

  void updateButton() async {
    _btnStatus = null;
    notifyListeners();
    SharedPref pref = new SharedPref();
    bool checkinToday =
    await userAction.getStatusCheckInToDay(await pref.getId());
    bool checkoutToday =
    await userAction.getStatusCheckOutToDay(await pref.getId());
    //_statusCheckIn = checkinToday;
    /* *
     * [Possible case]
     * [1] don't check-in and dont check-out = {buttonColor: green, buttonText: 'check-in'}
     * [2] check-in and don't check-out = {buttonColor: blue, buttonText: 'check-out'}
     * [3] check-in and check-out = {text: 'today you finished working'}
     * [Maybe possible case]
     * [5] check-out and dont check-in = {error: 'exception'}
     * */
    if (!checkinToday && !checkoutToday) {
      _btnStatus = 'check-in';
    } else if (checkinToday && !checkoutToday) {
      _btnStatus = 'check-out';
    } else if (checkinToday && checkoutToday) {
      _btnStatus = 'finished-working';
    } else {
      _btnStatus = 'exception';
    }
    log('change btnStatus finished');
    notifyListeners();
  }

  void setLastCheckIn() async {
    _lastDateCheckInStr = null;
    notifyListeners();
    WorkHoursApi workHourApi = new WorkHoursApi();
    SharedPref pref = new SharedPref();
    WorkHours workHours =
    await workHourApi.getLastCheckInById(await pref.getId());
    _lastDateCheckInStr = workHours.workHoursTimeWork;
    notifyListeners();
  }

  void setCurrentLocation() async {
    LocationData currentLocation;
    currentLocation = await getCurrentLocation();
    _latitude = currentLocation.latitude;
    _longitude = currentLocation.longitude;
    _latLongLoading = false; //disabled loading
    notifyListeners();
    _latLongLoading = true; //loading
  }

  void setStatusCheckInToDay() async {
    _statusCheckIn = null;
    UserAction userAction = new UserAction();
    SharedPref pref = new SharedPref();
    _statusCheckIn = await userAction.getStatusCheckInToDay(await pref.getId());
    notifyListeners();
  }

  void setDateTime() {
    _dateStr = getCurrentDate();
    _timeStr = getCurrentTime();
    log('{_dateStr: $_dateStr, _timeStr: $_timeStr}',name:'setDateTime');
    notifyListeners();
  }

  String getCurrentTime() {
    return _formatTime(DateTime.now());
  }

  String getCurrentDate() {
    return _formatDate(DateTime.now());
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    //print('set located');
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        log("Permission denied");
      }
      return null;
    }
  }

  getUserAgent() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName;
    if (Platform.isAndroid) {
      // Android-specific code
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model.toString();
      print('Running on ${androidInfo.model}');
    } else {
      // iOS-specific code
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine.toString();
      print('Running on ${iosInfo.utsname.machine}');
    }
    return deviceName;
  }
}
