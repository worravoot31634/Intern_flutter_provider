import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';

class SideBarProvider with ChangeNotifier{

  String _name;

  Widget _screen;

  bool _sideBarActive = false;

  BorderRadius _sideBarRadius = BorderRadius.all(Radius.circular(0));

  String get name => _name;

  Widget get screen => _screen;

  bool get sideBarActive => _sideBarActive;

  BorderRadius get sideBarRadius => _sideBarRadius;

  SideBarProvider(){
   initState();
   notifyListeners();
  }

  initState() async{
    SharedPref pref = new SharedPref();
    _name = await pref.getName();
  }

  setScreen(Widget screen) {
    _screen = screen;
    notifyListeners();
  }

  void closeSideBar() {
    log('closeSideBar', name: 'SideBar');
    _sideBarActive = false;
    _sideBarRadius = BorderRadius.all(Radius.circular(0));
    notifyListeners();
  }

  void openSideBar() {
    log('openSideBar', name: 'SideBar');
    _sideBarActive = true;
    _sideBarRadius = BorderRadius.all(Radius.circular(30));
    notifyListeners();
  }

}