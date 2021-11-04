// ignore_for_file: file_names

import 'package:evertask/models/single_task.dart';
import 'package:evertask/models/subtask.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

class SingleTasksVM extends ChangeNotifier {
  List<SingleTask> singleTasks = [
    SingleTask(
      title: 'Программирование',
      subtasks: [
        Subtask(title: 'Turn on PC'),
      ],
      startDate: DateTime.now()
    )
  ];

  List<SingleTask> get singleTasksForNow {
    return singleTasks.where((task) => task.startDate!.isBefore(DateTime.now())).toList();
  }

  // getData() async {
  //     var box = await Hive.openBox('SingleTasks');
  //     singleTasks = box.get('SingleTasksData');
  // }

  // saveData() async {
  //   var box = await Hive.openBox('SingleTasks');
  //   box.put('SingleTasksData', singleTasks);
  // }

  addTask(SingleTask task) {
    singleTasks.add(task);
    notifyListeners();
  }

  deleteTask(SingleTask deletedTask) {
    singleTasks.removeWhere((task) => task.id == deletedTask.id);
    notifyListeners();
  }

  completeTask(SingleTask updatesTask) async {
    singleTasks[singleTasks.indexWhere(
        (originTask) => originTask.id == updatesTask.id)] = updatesTask;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 650));
    deleteTask(updatesTask);
    notifyListeners();
  }

  completeSubtask(SingleTask singleTask) {
    singleTasks[singleTasks.indexWhere(
        (originTask) => originTask.id == singleTask.id)] = singleTask;
    notifyListeners();
  }
}
