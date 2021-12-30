import 'package:flutter/material.dart';
import 'package:task/src/models/utils.dart';

class Taskfield {
  static const createdTime = 'createdTime';
}

class Task {
  DateTime createdTime;
  String title;
  String summary;
  String id;
  bool isDone;
  String owner;

  Task(
      {@required this.createdTime,
      this.id,
      this.isDone = false,
      this.summary = '',
      this.owner,
      @required this.title});

  static Task fromJson(Map<String, dynamic> json) => Task(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      summary: json['summary'],
      id: json['id'],
      isDone: json['isDone'],
      owner: json['owner']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'summary': summary,
        'id': id,
        'isDone': isDone,
        'owner': owner
      };
}
