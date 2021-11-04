import 'package:evertask/models/subtask.dart';
import 'package:uuid/uuid.dart';

class SingleTask {
  String id = const Uuid().v4();
  String title;
  String? subtitle;
  bool complete;
  List<Subtask>? subtasks;
  DateTime? startDate = DateTime.now();

  SingleTask({required this.title, this.subtitle, this.complete = false, this.subtasks, this.startDate});
}

var task = SingleTask(title: 'title', complete: false, subtasks: []);