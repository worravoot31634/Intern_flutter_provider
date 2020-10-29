import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'file:///C:/Users/User/IdeaProjects/flutter_application_provider/lib/action/user_action.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';
import 'package:uuid/uuid.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController _ctrlUsername = TextEditingController();
  TextEditingController _ctrlPassword = TextEditingController();

  TextEditingController get ctrlUsername => _ctrlUsername;
  TextEditingController get ctrlPassword => _ctrlPassword;

  bool get tokenEmpty => _tokenEmpty;

  bool _tokenEmpty = false;

  LoginProvider() {
    log('Init', name: 'LoginProvider');
    initState();
  }

  initState() {
    checkToken();

  }

  void doLogin() async {
    UserAction userAction = new UserAction();
    String username = _ctrlUsername.text.trim();
    String password = _ctrlPassword.text.trim();
    bool loginSuccess = await userAction.doLogin(username, password);

    log('loginStatus: {status: $loginSuccess}');
    if (loginSuccess) {
      saveToken();
      Get.offNamed('home');
    } else {
      showSimpleNotification(Text("username or password invalid!"),
          duration: Duration(seconds: 2), background: Colors.red);
    }
    notifyListeners();
  }

  void saveToken() {
    SharedPref pref = new SharedPref();
    var uuid = Uuid();
    pref.setToken(uuid.v4());
  }

  void checkToken() async {
    SharedPref pref = new SharedPref();
    String token = await pref.getToken();
    if (token.isEmpty) {
      log('token NULL');
      _tokenEmpty = false;
    }else if (token.isNotEmpty){
      log('token NOT NULL');
      _tokenEmpty = true;
      log(token, name: 'token');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    log('login disposed');
    clearState();
    super.dispose();
  }

  clearState(){
    _ctrlUsername = TextEditingController();
    _ctrlPassword = TextEditingController();
    _tokenEmpty = false;
    notifyListeners();
  }

}
