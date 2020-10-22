import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPref {
  String _id;
  String _name;
  String _roleId;
  String _departmentId;
  String _token;
  String _tokenDateExpired;


  Future<String> getId() async {
    final storage = new FlutterSecureStorage();
    _id = await storage.read(key: 'id') ?? null;
    return _id;
  }

  Future<void> setId(String id) async {
    final storage = new FlutterSecureStorage();
   await storage.write(key: 'id', value: id);
  }

  Future<String> getName() async {
    final storage = new FlutterSecureStorage();
    _name = await storage.read(key: 'name') ?? null;
    return _name;
  }

  Future<void> setName(String name) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'name', value: name);
  }

  Future<String> getRoleId() async {
    final storage = new FlutterSecureStorage();
    _roleId = await storage.read(key: 'roleId') ?? null;
    return _roleId;
  }

  Future<void> setRoleId(String roleId) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'roleId', value: roleId);
  }

  Future<String> getDepartmentId() async {
    final storage = new FlutterSecureStorage();
    _departmentId = await storage.read(key: 'departmentId') ?? null;
    return _departmentId;
  }

  Future<void> setDepartmentId(String departmentId) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'departmentId', value: departmentId);
  }

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    _token = await storage.read(key: 'token') ?? null;
    return _token;
  }

  Future<void> setToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  Future<String> getTokenDateExpired() async {
    final storage = new FlutterSecureStorage();
    _tokenDateExpired = await storage.read(key: 'tokenDateExpired') ?? null;
    return _tokenDateExpired;
  }

  Future<void> setTokenDateExpired(String tokenDateExpired) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'tokenDateExpired', value: tokenDateExpired);
  }

}
