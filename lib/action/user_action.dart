import 'dart:developer';


import 'package:provider_flutter_application/api/user_api/user_api.dart';
import 'package:provider_flutter_application/api/user_api/work_hours_api.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/model/work_hours.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';

class UserAction {

  Future<bool> doLogin(String username, String password) async {
    try {
      //call service
      UserApi userApi = new UserApi();
      User userResponse = await userApi.getUserByLogin(username, password);

      if (userResponse.id.isNotEmpty) {
        if (setSharedPref(userResponse)) {
          log('save sharedPref success', name: 'doLoginAction');
        }

        return true;
      } else {
        print('login failed');
        return false;
      }
    } catch (_) {
      print('login failed');
      return false;
    }
  }

  bool setSharedPref(User user) {
    //print(user.toJson());
    try {
      SharedPref pref = SharedPref();
      pref.setId(user.id);
      pref.setName(user.name);
      pref.setDepartmentId(user.departmentId);
      pref.setRoleId(user.roleId);
      return true;
    } catch (error, stacktrace) {
      log('set sharedPref Error', name: 'setSharedPref');
      print("Exception occurred: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> getStatusCheckInToDay(String id) async {
    //get work hours
    WorkHoursApi workHourApi = new WorkHoursApi();
    List<WorkHours> workHours = await workHourApi.getTodayCheckInById(id);

    if (workHours.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getStatusCheckOutToDay(String id) async {
    //get work hours
    WorkHoursApi workHourApi = new WorkHoursApi();
    List<WorkHours> workHours = await workHourApi.getTodayCheckOutById(id);

    if (workHours.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
