import 'package:flutter/cupertino.dart';
import 'package:todo_appli/constants/tast_type.dart';

class Task{
  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.type,
});

  final TaskType type;
  final String title;
  final String description;
   bool isCompleted;

}