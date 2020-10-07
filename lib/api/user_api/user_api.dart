import 'package:dio/dio.dart' hide Headers;
import 'package:provider_flutter_application/model/user.dart';

import 'package:provider_flutter_application/api/api_client.dart';

class UserApi {
  Dio dio;
  ApiClient apiClient;

  UserApi() {
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<User> getUserByLogin(String id, String password) async {
    User response;
    User user = new User();
    user.id = id;
    user.password = password;

    try {
      response = await apiClient.getUserByLogin(user);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    return response;
  }
}
