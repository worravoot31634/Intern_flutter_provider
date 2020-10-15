import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LateCheckInProvider with ChangeNotifier{

  String _date;
  String _time;
  DateTime _firstDateSelectable = DateTime(DateTime.now().year, 1, 1,);
  DateTime _lastDateSelectable = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
  DateTime _defaultDate = DateTime.now();
  TimeOfDay _defaultTime = TimeOfDay.now();


  LateCheckInProvider (){

    initState();
    notifyListeners();
  }

  initState(){

    _time = DateFormat("HH:mm").format(DateTime.now());
    _date = DateFormat("d MMM yyyy").format(DateTime.now());
    notifyListeners();
  }

  void onTimeChanged(TimeOfDay newTime) {

      _defaultTime = newTime;
      final now = new DateTime.now();
      DateTime time = DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
      _time = DateFormat("HH:mm").format(time);
      notifyListeners();
  }

  void onDateChanged(DateTime newDate){
    _date = DateFormat("dd MMM yyyy").format(newDate);
    _defaultDate = newDate;
    notifyListeners();
  }

  String get date => _date;

  String get time => _time;

  DateTime get firstDateSelectable => _firstDateSelectable;

  DateTime get lastDateSelectable => _lastDateSelectable;

  DateTime get defaultDate => _defaultDate;

  TimeOfDay get defaultTime => _defaultTime;
}