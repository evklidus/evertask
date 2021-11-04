import 'package:evertask/view/components/single_task_tile.dart';
import 'package:evertask/view_models/single_tasksvm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleTasksList extends StatelessWidget {
  const SingleTasksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSingleTasks();
  }

  Widget buildSingleTasks() {
    return Consumer<SingleTasksVM>(
      builder: (context, singleTasksVM, _) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: singleTasksVM.singleTasksForNow.length,
        itemBuilder: (context, index) {
          final task = singleTasksVM.singleTasksForNow[index];
          return 
          Dismissible(
            key: Key(task.id),
            direction: DismissDirection.endToStart,
            background: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(Icons.delete_forever,
                      color: Colors.white, size: 50.0)),
            ),
            onDismissed: (direction) {
              singleTasksVM.deleteTask(task);
              // ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('${task.title} dismissed')));
            },
            child: 
            SingleTaskTile(
              key: Key(singleTasksVM.singleTasksForNow[index].id),
              task: singleTasksVM.singleTasksForNow[index],
              completeTask: singleTasksVM.completeTask,
              completeSubtask: singleTasksVM.completeSubtask,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
