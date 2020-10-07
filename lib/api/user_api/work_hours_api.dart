import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;

import 'package:provider_flutter_application/api/api_client.dart';
import 'package:provider_flutter_application/api/api_error_handling.dart';
import 'package:provider_flutter_application/api/base_model.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/model/work_hours.dart';

class WorkHoursApi {
  Dio dio;
  ApiClient apiClient;

  WorkHoursApi() {
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<BaseModel<String>> checkInAndOut(WorkHours workHours) async {
    String response;
    //log("send: " + workHours.toJson().toString());

    try {
      response = await apiClient.checkInAndOut(workHours);
      Map<String, dynamic> statusCheckIn = jsonDecode(response);
      //log("status CheckIn: " + statusCheckIn['status']);
      response = statusCheckIn['status'];
      //print("checkIn status from server :" + response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<WorkHours>>> getWorkHoursById(String id) async {
    List<WorkHours> response;
    User user = new User();
    user.id = id;

    try {
      response = await apiClient.getWorkHoursById(user);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<List<WorkHours>> getTodayCheckInById(String id) async {
    List<WorkHours> response;
    User user = new User();
    user.id = id;

    try {
      response = await apiClient.getTodayCheckInById(user);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

    }
    return response;
  }

  Future<List<WorkHours>> getTodayCheckOutById(String id) async {
    List<WorkHours> response;
    User user = new User();
    user.id = id;

    try {
      response = await apiClient.getTodayCheckOutById(user);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

    }
    return response;
  }

  Future<WorkHours> getLastCheckInById(String id) async {
    WorkHours response;
    User user = new User();
    user.id = id;

    try {
      response = await apiClient.getLastCheckInById(user);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

    }
    return response;
  }
}
