import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider_flutter_application/api/user_api/ticket_api.dart';
import 'package:provider_flutter_application/api/user_api/user_api.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';

class AddTicketProvider with ChangeNotifier {
  TextEditingController _ctrlTicketName = TextEditingController();
  TextEditingController _ctrlTicketUrl = TextEditingController();
  TextEditingController _ctrlDescription = TextEditingController();
  TextEditingController _ctrlExpectedResult = TextEditingController();
  TextEditingController _ctrlActualResult = TextEditingController();

  String _fileName;
  String _userCreate;
  String _userAssigned;
  FilePickerResult _resultFile;
  List<User> _userList;
  String _defaultSelectedUserCreate;
  String _defaultSelectedUserAssigned;

  AddTicketProvider() {
    init();
  }

  void init() async {
    clearTextField();
    SharedPref pref = new SharedPref();
    _fileName = null;
    _userCreate = await pref.getId();
    _userAssigned = null;
    _resultFile = null;
    _defaultSelectedUserCreate = null;
    _defaultSelectedUserAssigned = null;
    getAllUserList();
    notifyListeners();
  }

  void addFile() async {
    _resultFile = await FilePicker.platform.pickFiles();
    _fileName = _resultFile.files.last.name;
    notifyListeners();
  }

  void getAllUserList() async {
    SharedPref pref = new SharedPref();
    if (_userList != null) _userList.clear();

    UserApi userApi = new UserApi();
    _userList = await userApi.getAllUser();
    _userList.add(User(name: "(optional)"));
    _defaultSelectedUserCreate = await pref.getName();
    notifyListeners();
  }

  void addTicket() async {
    TicketApi ticketApi = new TicketApi();
    Ticket ticket = new Ticket();
    PlatformFile file;
    File fileUpload;
    String status;

    ticket.ticketName = _ctrlTicketName.text;
    ticket.ticketUrl = _ctrlTicketUrl.text;
    ticket.description = _ctrlDescription.text;
    ticket.expectedResult = _ctrlExpectedResult.text;
    ticket.actualResult = _ctrlActualResult.text;
    ticket.userCreate = _userCreate;
    if (_userAssigned != null) {
      ticket.userAssigned = _userAssigned;
    }

    if (_resultFile != null) {
      file = _resultFile.files.first;
      fileUpload = File(file.path);
      status = await ticketApi.addTicket(ticket, fileUpload, _fileName);
    } else {
      status = await ticketApi.addTicketWithoutFile(ticket);
    }
    Map<String, dynamic> statusJson = jsonDecode(status);

    if (statusJson["status"] == "success") {
      init();
      showSimpleNotification(Text("Add ticket success."),
          duration: Duration(seconds: 2), background: Colors.green);
      Timer(const Duration(seconds: 1), () {
          Get.back();
        },);
    } else {
      showSimpleNotification(Text("can't add ticket"),
          duration: Duration(seconds: 2), background: Colors.green);
    }
    notifyListeners();
  }

  void setUserCreate(User userCreate) {
    _userCreate = userCreate.id;
    _defaultSelectedUserCreate = userCreate.name;
    notifyListeners();
  }

  void setUserAssigned(User userAssigned) {
    String id;
    String name;
    if (userAssigned == null) {
      id = null;
      name = null;
    } else {
      id = userAssigned.id;
      name = userAssigned.name;
    }
    _userAssigned = id;
    _defaultSelectedUserAssigned = name;

    notifyListeners();
  }

  void clearTextField (){
    _ctrlTicketName.clear();
    _ctrlTicketUrl.clear();
    _ctrlDescription.clear();
    _ctrlExpectedResult.clear();
    _ctrlActualResult.clear();
    notifyListeners();
  }

  String get defaultSelectedUserCreate => _defaultSelectedUserCreate;

  String get defaultSelectedUserAssigned => _defaultSelectedUserAssigned;

  FilePickerResult get resultFile => _resultFile;

  String get fileName => _fileName;

  List<User> get userList => _userList;

  TextEditingController get ctrlActualResult => _ctrlActualResult;

  TextEditingController get ctrlExpectedResult => _ctrlExpectedResult;

  TextEditingController get ctrlDescription => _ctrlDescription;

  TextEditingController get ctrlTicketUrl => _ctrlTicketUrl;

  TextEditingController get ctrlTicketName => _ctrlTicketName;
}
