
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  String _id;
  String _name;
  String _roleId;
  String _departmentId;
  String _token;
  String _tokenDateExpired;


  Future<String> getId() async {
    //final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString("id") ?? null;
    return _id;
  }

  Future<void> setId(String id) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString("id", id);
  }

  Future<String> getName() async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? null;
    return _name;
  }

  Future<void> setName(String name) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
  }

  Future<String> getRoleId() async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _roleId = prefs.getString("roleId")?? null;
    return _roleId;
  }

  Future<void> setRoleId(String roleId) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("roleId", roleId);
  }

  Future<String> getDepartmentId() async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _departmentId = prefs.getString("departmentId") ?? null;
    return _departmentId;
  }

  Future<void> setDepartmentId(String departmentId) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("departmentId", departmentId);
  }

  Future<String> getToken() async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token") ?? null;
    return _token;
  }

  Future<void> setToken(String token) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<String> getTokenDateExpired() async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenDateExpired = prefs.getString("tokenDateExpired") ?? null;
    return _tokenDateExpired;
  }

  Future<void> setTokenDateExpired(String tokenDateExpired) async {
    // final storage = new FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("tokenDateExpired", tokenDateExpired);
  }

}
