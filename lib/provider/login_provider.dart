import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/action/user_action.dart';
import 'package:provider_flutter_application/model/user.dart';

class LoginProvider extends ChangeNotifier {
  String _username;
  String _password;

  String _loading = "Idle";
  String get loading => _loading;

  void doLogin({String username, String password}) async {
    UserAction userAction = new UserAction();
    loadingInProgress(); //In progress

    bool loginSuccess = await userAction.doLoginAction(username, password);

    log('loginStatus: {status: $loginSuccess}');
    if (loginSuccess) {
      _loading = "Success";
      notifyListeners();
    } else {
      _loading = "Failed";
      notifyListeners();
    }
  }
  void loadingInProgress() {
    _loading = "InProgress";
    notifyListeners();
  }
}
