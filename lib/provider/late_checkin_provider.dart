import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider_flutter_application/action/holiday_action.dart';
import 'package:provider_flutter_application/api/user_api/work_hours_api.dart';
import 'package:provider_flutter_application/model/work_hours.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_flutter_application/utils/utils.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class LateCheckInProvider with ChangeNotifier {
  //Google Map
  Completer<GoogleMapController> _mapController = Completer();

  //required data for late CheckIn-Out
  String _id;
  String _checkInType;
  String _userAgent;
  String _ipAddress;
  double _latitude;
  double _longitude;
  String _description = '';

  String _date;
  String _time;

  //DateTime _firstDateSelectable = DateTime(DateTime.now().year, 1, 1,);
  DateTime _lastDateSelectable = DateTime(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, 23, 59, 59);
  DateTime _defaultDate = DateTime.now();
  TimeOfDay _defaultTime = TimeOfDay.now();

  //calendar
  int _enableStatus = 0;
  List<DateTime> _holidayList;
  List<DateTime> _listDateDisabled;
  int _virtualDays = 12;
  DateTime _virtualCurrentDate;
  DateTime _firstDateSelectable;
  int _virtualHours;
  int _virtualMinutes;
  int _virtualSeconds;

  TextEditingController _ctrlDescription = TextEditingController();
  Color _textFieldDesColor = Color(0xff29404E);
  String _labelTextDes = '';

  LateCheckInProvider() {
    initState();
    notifyListeners();
  }

  initState() {
    initCalendar();
    // _firstDateSelectable = DateTime.now().subtract(Duration(days: 20));
    // _lastDateSelectable = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    _defaultDate = DateTime.now();
    _defaultTime = TimeOfDay.now();
    _time = DateFormat("HH:mm").format(DateTime.now());
    _date = DateFormat("d MMM yyyy").format(DateTime.now());
    notifyListeners();
    //checkListDateDisabled(); //for disable date cant checkin-out
    initCheckData(); //for checkin-out
  }

  void initCheckData() async {
    Utils utils = new Utils();
    LocationData locationData = await utils.getLocation();
    _id = await utils.getId();
    _userAgent = await utils.getUserAgent();
    _ipAddress = await utils.getIpAddress();
    _latitude = locationData.latitude;
    _longitude = locationData.longitude;
    log('initCheckData finished');
  }

  void changeEnableButton(int btnStatus) {
    _enableStatus = btnStatus;
    initCalendar();
    notifyListeners();
  }

  void checkListDateDisabled() {
    if (_listDateDisabled != null) _listDateDisabled.clear();
    _listDateDisabled.add(DateTime.now().subtract(Duration(days: 2)));
    notifyListeners();
  }

  void confirmLateCheckIn(BuildContext context, String checkInType) async {
    String timeWorkStr = '$_date $_time';
    var parsedTimeWork =
        DateFormat('d MMM yyyy HH:mm', 'en_US').parse(timeWorkStr);

    Utils utils = new Utils();
    LocationData locationData = await utils.getLocation();
    _latitude = locationData.latitude;
    _longitude = locationData.longitude;
    WorkHoursApi workHoursApi = new WorkHoursApi();
    WorkHours workHours = new WorkHours();
    workHours.userCreate = _id;
    workHours.workHoursType = checkInType;
    workHours.workHoursTimeWork = parsedTimeWork.toString();
    workHours.latitude = _latitude.toString();
    workHours.longitude = _longitude.toString();
    workHours.description = _description;
    workHours.userAgent = _userAgent;
    workHours.ipAddress = _ipAddress;

    // log("DATA: " + workHours.toJson().toString());
    String status = await workHoursApi.lateCheckInAndOut(workHours);
    // log('status: {$status}', name: 'LateCheckInProvider');
    if (status == 'success') {
      showSimpleNotification(Text("Late Check In success!"),
          duration: Duration(seconds: 2), background: Colors.green);
      Get.back(); //close pop up
      Get.back(); //close late check in screen
      context.read<HomeProvider>().updateButton();
      if (checkInType == '1') context.read<HomeProvider>().setLastCheckIn();
    } else if (status == 'ErrorTimeFuture') {
      log("Can't check-in-out in the future");
      showSimpleNotification(Text("Can't choose a time In Future!"),
          duration: Duration(seconds: 2), background: Colors.red);
    }
  }

  void onTimeChanged(TimeOfDay newTime) {
    _defaultTime = newTime;
    final now = new DateTime.now();
    DateTime time =
        DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
    _time = DateFormat("HH:mm").format(time);
    log('time: {$_time}', name: 'onTimeChanged');
    notifyListeners();
  }

  void onDateChanged(DateTime newDate) {
    _date = DateFormat("d MMM yyyy").format(newDate);
    _defaultDate = newDate;
    log('time: {$_defaultDate}', name: 'onDateChanged');
    notifyListeners();
  }

  void initCalendar() async {
    if (_enableStatus == 1) {
      HolidayAction holidayAction = new HolidayAction();
      _holidayList = await holidayAction.getAllDateHoliday();
      _listDateDisabled = new List<DateTime>();
      _virtualCurrentDate = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          _virtualDays,
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second);

      _firstDateSelectable = _virtualCurrentDate;
      _virtualHours = _virtualCurrentDate.hour;
      _virtualMinutes = _virtualCurrentDate.minute;
      _virtualSeconds = _virtualCurrentDate.second;

      if (_virtualCurrentDate.weekday >= 2 &&
          _virtualCurrentDate.weekday <= 5) {
        //tuesday-friday
        //can late checkin-out 1 day before
        _firstDateSelectable = _virtualCurrentDate.subtract(Duration(days: 2));
      } else if (_virtualCurrentDate.weekday == 1) {
        //monday
        //can late checkin-out 1 day before include Friday and Sunday
        _firstDateSelectable = _virtualCurrentDate.subtract(Duration(days: 4));
        _listDateDisabled.add(_virtualCurrentDate.subtract(Duration(days: 2)));
      } else if (_virtualCurrentDate.weekday == 6) {
        //saturday
        _firstDateSelectable = _virtualCurrentDate.subtract(Duration(days: 2));
        _listDateDisabled.add(_virtualCurrentDate.subtract(Duration(days: 3)));
      } else if (_virtualCurrentDate.weekday == 7) {
        //sunday
        _firstDateSelectable = _virtualCurrentDate.subtract(Duration(days: 3));
      }

      // add current hour minute second
      for (int i = 0; i < _holidayList.length; i++) {
        _holidayList[i] = DateTime(
            _holidayList[i].year,
            _holidayList[i].month,
            _holidayList[i].day,
            _virtualHours,
            _virtualMinutes,
            _virtualSeconds);
        //log('subtract: ${holidayList[i]}');
      }

      /* check Holiday */
      for (int i = _holidayList.length - 1; i >= 0; i--) {
        log('round $i : ${_holidayList[i].toString()}', name: 'holidayList');
        log('round $i : ${_firstDateSelectable.toString()}',
            name: 'holidayList');
        _listDateDisabled.add(_holidayList[i]);
        /* case holiday same day's can check-in-out then [firstDateSelectable add duration +1] */
        if (_holidayList[i].subtract(Duration(days: 1)) ==
            _firstDateSelectable) {
          log('same Holiday: {${_holidayList[i]}}, firstDateSelectable : {$_firstDateSelectable}');
          _firstDateSelectable =
              _firstDateSelectable.subtract(Duration(days: 1));
        }
      }
    } else {
      if(_listDateDisabled != null) _listDateDisabled.clear();
      _firstDateSelectable = _virtualCurrentDate.subtract(Duration(days: 30));
    }

    notifyListeners();
  }

  void onDescriptionChanged(String des) {
    _description = des;
    if (des.length >= 10) {
      _labelTextDes = 'OK';
      _textFieldDesColor = Colors.green;
    } else if (des.length < 10 && des.length != 0) {
      _labelTextDes = 'more than 10 characters';
      _textFieldDesColor = Colors.red[700];
    } else if (des.length == 0) {
      _labelTextDes = '';
      _textFieldDesColor = Color(0xff29404E);
    }
    notifyListeners();
  }

  Completer<GoogleMapController> get mapController => _mapController;

  String get id => _id;

  String get date => _date;

  String get time => _time;

  DateTime get firstDateSelectable => _firstDateSelectable;

  DateTime get lastDateSelectable => _lastDateSelectable;

  DateTime get defaultDate => _defaultDate;

  TimeOfDay get defaultTime => _defaultTime;

  TextEditingController get ctrlDescription => _ctrlDescription;

  String get description => _description;

  String get ipAddress => _ipAddress;

  String get userAgent => _userAgent;

  String get checkInType => _checkInType;

  double get longitude => _longitude;

  double get latitude => _latitude;

  Color get textFieldDesColor => _textFieldDesColor;

  String get labelTextDes => _labelTextDes;

  List<DateTime> get listDateDisabled => _listDateDisabled;

  int get virtualSeconds => _virtualSeconds;

  int get virtualMinutes => _virtualMinutes;

  int get virtualHours => _virtualHours;

  DateTime get virtualCurrentDate => _virtualCurrentDate;

  int get virtualDays => _virtualDays;

  List<DateTime> get holidayList => _holidayList;

  int get enableStatus => _enableStatus;
}
