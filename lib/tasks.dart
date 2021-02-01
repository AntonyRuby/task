import 'package:flutter/material.dart';
import 'package:task/utils.dart';

class Taskfield {
  static const createdTime = 'createdTime';
}

class Task {
  DateTime createdTime;
  String title;
  String summary;
  String id;
  bool isDone;

  Task(
      {@required this.createdTime,
      this.id,
      this.isDone = false,
      this.summary = '',
      @required this.title});

  static Task fromJson(Map<String, dynamic> json) => Task(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      summary: json['summary'],
      id: json['id'],
      isDone: json['isDone']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'summary': summary,
        'id': id,
        'isDone': isDone,
      };
}
