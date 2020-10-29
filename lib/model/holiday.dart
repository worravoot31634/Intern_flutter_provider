import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

Holiday holidayFromJson(String str) => Holiday.fromJson(json.decode(str));

String holidayToJson(Holiday data) => json.encode(data.toJson());

@JsonSerializable()
class Holiday {
  Holiday({
    this.idDate,
    this.startDate,
    this.endDate,
    this.head,
    this.description,
  });

  int idDate;
  String startDate;
  String endDate;
  String head;
  String description;

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    idDate: json["id_date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    head: json["head"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id_date": idDate,
    "start_date": startDate,
    "end_date": endDate,
    "head": head,
    "description": description,
  };
}
