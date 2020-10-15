import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider_flutter_application/action/user_action.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/screens/home_screen.dart';

class LoginProvider extends ChangeNotifier {

  TextEditingController _ctrlUsername = TextEditingController();
  TextEditingController _ctrlPassword = TextEditingController();

  TextEditingController get ctrlUsername => _ctrlUsername;
  TextEditingController get ctrlPassword => _ctrlPassword;

  /// status have 4 possible value =
  /// Idle, InProgress, Success, Failed
  String _loading = "idle";
  String get loading => _loading;

  void doLogin({String username, String password}) async {
    UserAction userAction = new UserAction();
    loadingInProgress(); //In progress

    bool loginSuccess = await userAction.doLoginAction(username, password);

    log('loginStatus: {status: $loginSuccess}');
    if (loginSuccess) {
      _loading = "success";
      Get.toNamed('home');
      notifyListeners();
    } else {
      _loading = "failed";
      notifyListeners();
    }
  }
  void loadingInProgress() {
    _loading = "inProgress";
    notifyListeners();
  }


}
