import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

@JsonSerializable()
class Article {
  Article({
    this.timeCreate,
    this.typeName,
    this.userUpdate,
    this.type,
    this.userCreate,
    this.articleId,
    this.timeUpdate,
    this.path,
    this.articleTypeId,
    this.userId,
    this.fileId,
    this.topic,
    this.detail,
  });

  String timeCreate;
  String typeName;
  String userUpdate;
  String type;
  String userCreate;
  int articleId;
  String timeUpdate;
  String path;
  int articleTypeId;
  String userId;
  int fileId;
  String topic;
  String detail;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        timeCreate: json["time_create"] == null ? null : json["time_create"],
        typeName: json["type_name"] == null ? null : json["type_name"],
        userUpdate: json["user_update"] == null ? null : json["user_update"],
        type: json["type"] == null ? null : json["type"],
        userCreate: json["user_create"] == null ? null : json["user_create"],
        articleId: json["article_id"] == null ? null : json["article_id"],
        timeUpdate: json["time_update"] == null ? null : json["time_update"],
        path: json["path"] == null ? null : json["path"],
        articleTypeId:
            json["article_type_id"] == null ? null : json["article_type_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fileId: json["file_id"] == null ? null : json["file_id"],
        topic: json["topic"] == null ? null : json["topic"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "time_create": timeCreate == null ? null : timeCreate,
        "type_name": typeName == null ? null : typeName,
        "user_update": userUpdate == null ? null : userUpdate,
        "type": type == null ? null : type,
        "user_create": userCreate == null ? null : userCreate,
        "article_id": articleId == null ? null : articleId,
        "time_update": timeUpdate == null ? null : timeUpdate,
        "path": path == null ? null : path,
        "article_type_id": articleTypeId == null ? null : articleTypeId,
        "user_id": userId == null ? null : userId,
        "file_id": fileId == null ? null : fileId,
        "topic": topic == null ? null : topic,
        "detail": detail == null ? null : detail,
      };
}
