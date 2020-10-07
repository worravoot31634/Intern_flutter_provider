// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@JsonSerializable()
class User {
  User({
    this.id,
    this.roleId,
    this.departmentId,
    this.managerId,
    this.positionId,
    this.employeeId,
    this.name,
    this.nickName,
    this.password,
    this.email,
    this.emailPassword,
    this.emailEnable,
    this.birthDate,
    this.flagSearch,
    this.address,
    this.startDate,
    this.endDate,
    this.workDayStart,
    this.workDayEnd,
    this.workTimeStart,
    this.workTimeEnd,
    this.latestSalary,
    this.eduInstitute1,
    this.eduInstitute2,
    this.eduInstitute3,
    this.eduInstitute4,
    this.eduDurStart1,
    this.eduDurStart2,
    this.eduDurStart3,
    this.eduDurStart4,
    this.eduDurEnd1,
    this.eduDurEnd2,
    this.eduDurEnd3,
    this.eduDurEnd4,
    this.eduDegree1,
    this.eduDegree2,
    this.eduDegree3,
    this.eduDegree4,
    this.enable,
    this.leaveQuota1,
    this.leaveQuota2,
    this.leaveQuota3,
    this.leaveQuota4,
    this.timeCreate,
    this.timeUpdate,
    this.emailHost,
    this.passwordUpdate,
    this.loginFailed,
    this.lastLoginFailedTime,
    this.path,
    this.facebookid,
    this.lineId,
    this.phoneNum,
    this.gender,
  });

  String id;
  String roleId;
  String departmentId;
  String managerId;
  String positionId;
  String employeeId;
  String name;
  String nickName;
  String password;
  String email;
  String emailPassword;
  String emailEnable;
  String birthDate;
  String flagSearch;
  String address;
  String startDate;
  String endDate;
  String workDayStart;
  String workDayEnd;
  String workTimeStart;
  String workTimeEnd;
  double latestSalary;
  String eduInstitute1;
  String eduInstitute2;
  String eduInstitute3;
  String eduInstitute4;
  String eduDurStart1;
  String eduDurStart2;
  String eduDurStart3;
  String eduDurStart4;
  String eduDurEnd1;
  String eduDurEnd2;
  String eduDurEnd3;
  String eduDurEnd4;
  String eduDegree1;
  String eduDegree2;
  String eduDegree3;
  String eduDegree4;
  String enable;
  double leaveQuota1;
  double leaveQuota2;
  double leaveQuota3;
  double leaveQuota4;
  String timeCreate;
  String timeUpdate;
  String emailHost;
  String passwordUpdate;
  int loginFailed;
  String lastLoginFailedTime;
  String path;
  String facebookid;
  String lineId;
  String phoneNum;
  String gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        roleId: json["roleId"] == null ? null : json["roleId"],
        departmentId:
            json["departmentId"] == null ? null : json["departmentId"],
        managerId: json["managerId"] == null ? null : json["managerId"],
        positionId: json["positionId"] == null ? null : json["positionId"],
        employeeId: json["employeeId"] == null ? null : json["employeeId"],
        name: json["name"] == null ? null : json["name"],
        nickName: json["nickName"] == null ? null : json["nickName"],
        password: json["password"] == null ? null : json["password"],
        email: json["email"] == null ? null : json["email"],
        emailPassword:
            json["emailPassword"] == null ? null : json["emailPassword"],
        emailEnable: json["emailEnable"] == null ? null : json["emailEnable"],
        birthDate: json["birthDate"] == null ? null : json["birthDate"],
        flagSearch: json["flagSearch"] == null ? null : json["flagSearch"],
        address: json["address"] == null ? null : json["address"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        workDayStart:
            json["workDayStart"] == null ? null : json["workDayStart"],
        workDayEnd: json["workDayEnd"] == null ? null : json["workDayEnd"],
        workTimeStart:
            json["workTimeStart"] == null ? null : json["workTimeStart"],
        workTimeEnd: json["workTimeEnd"] == null ? null : json["workTimeEnd"],
        latestSalary: json["latestSalary"] == null
            ? null
            : json["latestSalary"].toDouble(),
        eduInstitute1:
            json["eduInstitute1"] == null ? null : json["eduInstitute1"],
        eduInstitute2:
            json["eduInstitute2"] == null ? null : json["eduInstitute2"],
        eduInstitute3:
            json["eduInstitute3"] == null ? null : json["eduInstitute3"],
        eduInstitute4:
            json["eduInstitute4"] == null ? null : json["eduInstitute4"],
        eduDurStart1:
            json["eduDurStart1"] == null ? null : json["eduDurStart1"],
        eduDurStart2:
            json["eduDurStart2"] == null ? null : json["eduDurStart2"],
        eduDurStart3:
            json["eduDurStart3"] == null ? null : json["eduDurStart3"],
        eduDurStart4:
            json["eduDurStart4"] == null ? null : json["eduDurStart4"],
        eduDurEnd1: json["eduDurEnd1"] == null ? null : json["eduDurEnd1"],
        eduDurEnd2: json["eduDurEnd2"] == null ? null : json["eduDurEnd2"],
        eduDurEnd3: json["eduDurEnd3"] == null ? null : json["eduDurEnd3"],
        eduDurEnd4: json["eduDurEnd4"] == null ? null : json["eduDurEnd4"],
        eduDegree1: json["eduDegree1"] == null ? null : json["eduDegree1"],
        eduDegree2: json["eduDegree2"] == null ? null : json["eduDegree2"],
        eduDegree3: json["eduDegree3"] == null ? null : json["eduDegree3"],
        eduDegree4: json["eduDegree4"] == null ? null : json["eduDegree4"],
        enable: json["enable"] == null ? null : json["enable"],
        leaveQuota1:
            json["leaveQuota1"] == null ? null : json["leaveQuota1"].toDouble(),
        leaveQuota2:
            json["leaveQuota2"] == null ? null : json["leaveQuota2"].toDouble(),
        leaveQuota3:
            json["leaveQuota3"] == null ? null : json["leaveQuota3"].toDouble(),
        leaveQuota4:
            json["leaveQuota4"] == null ? null : json["leaveQuota4"].toDouble(),
        timeCreate: json["timeCreate"] == null ? null : json["timeCreate"],
        timeUpdate: json["timeUpdate"] == null ? null : json["timeUpdate"],
        emailHost: json["emailHost"] == null ? null : json["emailHost"],
        passwordUpdate:
            json["passwordUpdate"] == null ? null : json["passwordUpdate"],
        loginFailed: json["loginFailed"] == null ? null : json["loginFailed"],
        lastLoginFailedTime: json["lastLoginFailedTime"] == null
            ? null
            : json["lastLoginFailedTime"],
        path: json["path"] == null ? null : json["path"],
        facebookid: json["facebookid"] == null ? null : json["facebookid"],
        lineId: json["line_id"] == null ? null : json["line_id"],
        phoneNum: json["phone_num"] == null ? null : json["phone_num"],
        gender: json["gender"] == null ? null : json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "roleId": roleId == null ? null : roleId,
        "departmentId": departmentId == null ? null : departmentId,
        "managerId": managerId == null ? null : managerId,
        "positionId": positionId == null ? null : positionId,
        "employeeId": employeeId == null ? null : employeeId,
        "name": name == null ? null : name,
        "nickName": nickName == null ? null : nickName,
        "password": password == null ? null : password,
        "email": email == null ? null : email,
        "emailPassword": emailPassword == null ? null : emailPassword,
        "emailEnable": emailEnable == null ? null : emailEnable,
        "birthDate": birthDate == null ? null : birthDate,
        "flagSearch": flagSearch == null ? null : flagSearch,
        "address": address == null ? null : address,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "workDayStart": workDayStart == null ? null : workDayStart,
        "workDayEnd": workDayEnd == null ? null : workDayEnd,
        "workTimeStart": workTimeStart == null ? null : workTimeStart,
        "workTimeEnd": workTimeEnd == null ? null : workTimeEnd,
        "latestSalary": latestSalary == null ? null : latestSalary,
        "eduInstitute1": eduInstitute1 == null ? null : eduInstitute1,
        "eduInstitute2": eduInstitute2 == null ? null : eduInstitute2,
        "eduInstitute3": eduInstitute3 == null ? null : eduInstitute3,
        "eduInstitute4": eduInstitute4 == null ? null : eduInstitute4,
        "eduDurStart1": eduDurStart1 == null ? null : eduDurStart1,
        "eduDurStart2": eduDurStart2 == null ? null : eduDurStart2,
        "eduDurStart3": eduDurStart3 == null ? null : eduDurStart3,
        "eduDurStart4": eduDurStart4 == null ? null : eduDurStart4,
        "eduDurEnd1": eduDurEnd1 == null ? null : eduDurEnd1,
        "eduDurEnd2": eduDurEnd2 == null ? null : eduDurEnd2,
        "eduDurEnd3": eduDurEnd3 == null ? null : eduDurEnd3,
        "eduDurEnd4": eduDurEnd4 == null ? null : eduDurEnd4,
        "eduDegree1": eduDegree1 == null ? null : eduDegree1,
        "eduDegree2": eduDegree2 == null ? null : eduDegree2,
        "eduDegree3": eduDegree3 == null ? null : eduDegree3,
        "eduDegree4": eduDegree4 == null ? null : eduDegree4,
        "enable": enable == null ? null : enable,
        "leaveQuota1": leaveQuota1 == null ? null : leaveQuota1,
        "leaveQuota2": leaveQuota2 == null ? null : leaveQuota2,
        "leaveQuota3": leaveQuota3 == null ? null : leaveQuota3,
        "leaveQuota4": leaveQuota4 == null ? null : leaveQuota4,
        "timeCreate": timeCreate == null ? null : timeCreate,
        "timeUpdate": timeUpdate == null ? null : timeUpdate,
        "emailHost": emailHost == null ? null : emailHost,
        "passwordUpdate": passwordUpdate == null ? null : passwordUpdate,
        "loginFailed": loginFailed == null ? null : loginFailed,
        "lastLoginFailedTime":
            lastLoginFailedTime == null ? null : lastLoginFailedTime,
        "path": path == null ? null : path,
        "facebookid": facebookid == null ? null : facebookid,
        "line_id": lineId == null ? null : lineId,
        "phone_num": phoneNum == null ? null : phoneNum,
        "gender": gender == null ? null : gender,
      };
}
