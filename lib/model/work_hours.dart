import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

WorkHours workHoursFromJson(String str) => WorkHours.fromJson(json.decode(str));

String workHoursToJson(WorkHours data) => json.encode(data.toJson());

@JsonSerializable()
class WorkHours {
  WorkHours({
    this.timeCreate,
    this.timeUpdate,
    this.workHoursId,
    this.workHoursType,
    this.workHoursTimeWork,
    this.latitude,
    this.longitude,
    this.description,
    this.userAgent,
    this.myhour,
    this.ipAddress,
    this.mymin,
    this.userCreate,
    this.userUpdate,
  });

  String timeCreate;
  String timeUpdate;
  int workHoursId;
  String workHoursType;
  String workHoursTimeWork;
  String latitude;
  String longitude;
  String description;
  String userAgent;
  int myhour;
  String ipAddress;
  int mymin;
  String userCreate;
  String userUpdate;

  factory WorkHours.fromJson(Map<String, dynamic> json) => WorkHours(
        timeCreate: json["time_create"] == null ? null : json["time_create"],
        timeUpdate: json["time_update"] == null ? null : json["time_update"],
        workHoursId:
            json["work_hours_id"] == null ? null : json["work_hours_id"],
        workHoursType:
            json["work_hours_type"] == null ? null : json["work_hours_type"],
        workHoursTimeWork: json["work_hours_time_work"] == null
            ? null
            : json["work_hours_time_work"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        description: json["description"] == null ? null : json["description"],
        userAgent: json["userAgent"] == null ? null : json["userAgent"],
        myhour: json["myhour"] == null ? null : json["myhour"],
        ipAddress: json["ip_address"] == null ? null : json["ip_address"],
        mymin: json["mymin"] == null ? null : json["mymin"],
        userCreate: json["user_create"] == null ? null : json["user_create"],
        userUpdate: json["user_update"] == null ? null : json["user_update"],
      );

  Map<String, dynamic> toJson() => {
        "time_create": timeCreate == null ? null : timeCreate,
        "time_update": timeUpdate == null ? null : timeUpdate,
        "work_hours_id": workHoursId == null ? null : workHoursId,
        "work_hours_type": workHoursType == null ? null : workHoursType,
        "work_hours_time_work":
            workHoursTimeWork == null ? null : workHoursTimeWork,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "description": description == null ? null : description,
        "userAgent": userAgent == null ? null : userAgent,
        "myhour": myhour == null ? null : myhour,
        "ip_address": ipAddress == null ? null : ipAddress,
        "mymin": mymin == null ? null : mymin,
        "user_create": userCreate == null ? null : userCreate,
        "user_update": userUpdate == null ? null : userUpdate,
      };
}
