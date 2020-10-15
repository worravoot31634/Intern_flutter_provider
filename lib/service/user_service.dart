import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider_flutter_application/global.dart';

class UserService {
  Future<User> getUserByIdAndPassword(String username, String password) async {
    String _url = '${Global.BASE_API_URL}/ms-user-login'; //api_url + api_key
    print(_url);

    // var body =
    //     jsonEncode(<String, String>{'id': username, 'password': password});
    String body = '{"id":"worrawoot.s","password":"1234"}';

    var response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: "id=" + username);

    Map map = json.decode(response.body);
    print("Map: " + map.toString());
    User user = User.fromJson(map);

    return user;
  }

  Future<User> getUserByIdTest(String username, String password) async {
    String _url = '${Global.BASE_API_URL}/ms-user-login'; //api_url + api_key
    print(_url);

    Response response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "id": username,
      "password": password,
    });
    response = await dio.post(_url, data: formData);

    Map map = json.decode(response.data);
    print("Map: " + map.toString());
    User user = User.fromJson(map);

    print(response);
    return user;
  }
}
