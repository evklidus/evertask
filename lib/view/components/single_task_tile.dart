import 'package:evertask/models/single_task.dart';
import 'package:evertask/models/subtask.dart';
import 'package:evertask/view/components/check.dart';
import 'package:evertask/view_models/single_tasksVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleTaskTile extends StatelessWidget {
  SingleTaskTile({
    Key? key,
    required this.task,
    required this.completeTask,
    required this.completeSubtask,
  }) : super(key: key);

  final SingleTask task;

  final Function completeTask;

  final Function completeSubtask;
  
  double dragValue = 0.0;

  @override
  Widget build(BuildContext context) {
    // final tasks = Provider.of<SingleTasksVM>(context, listen: false);
    return buildSingleTask(context);
  }

  Widget buildSingleTask(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.height / 1.1,
              color: const Color(0xff1D1B29),
              child: Container(
                margin:
                    const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                child: Column(
                  children: [
                    buildMainTask(context),
                    if (task.subtasks != null)
                      ...task.subtasks!
                          .map((subtask) => buildSubtask(context, subtask))
                          .toList()
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildMainTask(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Check(
            complete: task.complete,
            mainTask: true,
          ),
          onTap: () {
            task.complete = !task.complete;
            completeTask(task);
          },
        ),
        Column(
          children: [
            Text(
              task.title,
            ),
            if (task.subtitle != null)
              Text(
                task.subtitle!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        )
      ],
    );
  }

  Widget buildSubtask(BuildContext context, Subtask subtask) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Row(
        children: [
          InkWell(
            child: Check(
              complete: subtask.complete,
              mainTask: false,
            ),
            onTap: () {
              subtask.complete = !subtask.complete;
              task.subtasks![task.subtasks!.indexWhere(
                  (originSubtask) => originSubtask.id == subtask.id)] = subtask;
              completeSubtask(task);
            },
          ),
          Text(
            subtask.title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
//singleTasks[singleTasks.indexWhere((updatesTask) => updatesTask.id == updatesTask.id)]