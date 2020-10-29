
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

@JsonSerializable()
class Ticket {
  Ticket({
    this.timeCreate,
    this.ticketStatusId,
    this.timeSuccess,
    this.description,
    this.ticketStatusName,
    this.ticketId,
    this.ticketUrl,
    this.userCreate,
    this.timeAssigned,
    this.ticketName,
    this.userAssigned,
    this.fileId,
    this.actualResult,
    this.expectedResult,
    this.fileUpload,
  });

  String timeCreate;
  int ticketStatusId;
  String timeSuccess;
  String description;
  String ticketStatusName;
  int ticketId;
  String ticketUrl;
  String userCreate;
  String timeAssigned;
  String ticketName;
  String userAssigned;
  int fileId;
  String actualResult;
  String expectedResult;
  File fileUpload;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    timeCreate: json["time_create"],
    ticketStatusId: json["ticket_status_id"],
    timeSuccess: json["time_success"],
    description: json["description"],
    ticketStatusName: json["ticket_status_name"],
    ticketId: json["ticket_id"],
    ticketUrl: json["ticket_url"],
    userCreate: json["user_create"],
    timeAssigned: json["time_assigned"],
    ticketName: json["ticket_name"],
    userAssigned: json["user_assigned"],
    fileId: json["file_id"],
    actualResult: json["actual_result"],
    expectedResult: json["expected_result"],
    fileUpload: json["file_upload"],
  );

  Map<String, dynamic> toJson() => {
    "time_create": timeCreate,
    "ticket_status_id": ticketStatusId,
    "time_success": timeSuccess,
    "description": description,
    "ticket_status_name": ticketStatusName,
    "ticket_id": ticketId,
    "ticket_url": ticketUrl,
    "user_create": userCreate,
    "time_assigned": timeAssigned,
    "ticket_name": ticketName,
    "user_assigned": userAssigned,
    "file_id": fileId,
    "actual_result": actualResult,
    "expected_result": expectedResult,
    "file_upload": fileUpload,
  };
}
