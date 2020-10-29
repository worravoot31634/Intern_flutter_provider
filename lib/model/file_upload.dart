

import 'dart:convert';

FileUpload fileUploadFromJson(String str) => FileUpload.fromJson(json.decode(str));

String fileUploadToJson(FileUpload data) => json.encode(data.toJson());

class FileUpload {
  FileUpload({
    this.fileId,
    this.userId,
    this.name,
    this.type,
    this.size,
    this.path,
    this.userCreate,
    this.userUpdate,
    this.timeCreate,
    this.timeUpdate,
  });

  int fileId;
  String userId;
  String name;
  String type;
  String size;
  String path;
  String userCreate;
  String userUpdate;
  String timeCreate;
  String timeUpdate;

  factory FileUpload.fromJson(Map<String, dynamic> json) => FileUpload(
    fileId: json["fileId"],
    userId: json["userId"],
    name: json["name"],
    type: json["type"],
    size: json["size"],
    path: json["path"],
    userCreate: json["userCreate"],
    userUpdate: json["userUpdate"],
    timeCreate: json["timeCreate"],
    timeUpdate: json["timeUpdate"],
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId,
    "userId": userId,
    "name": name,
    "type": type,
    "size": size,
    "path": path,
    "userCreate": userCreate,
    "userUpdate": userUpdate,
    "timeCreate": timeCreate,
    "timeUpdate": timeUpdate,
  };
}
