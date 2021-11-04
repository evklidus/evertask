import 'package:uuid/uuid.dart';

class Subtask {
  String id = const Uuid().v4();
  String title;
  bool complete;

  Subtask({required this.title, this.complete = false});
}