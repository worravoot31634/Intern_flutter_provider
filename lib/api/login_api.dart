import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider_flutter_application/global.dart';

class LoginApi {
  String endPoint = 'http://192.168.0.110:3000';
  String key = Global.API_ACCESS_KEY;

  Future<http.Response> doLogin(String username, String password) {
    String _url = '$endPoint/$key/login';

    var body =
        jsonEncode(<String, String>{'id': username, 'password': password});
    print("send Body: " + body.toString());
    return http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
  }
}
