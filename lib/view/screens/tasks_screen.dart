import 'package:evertask/view/components/single_task_list.dart';
import 'package:evertask/view/screens/add_task_screen.dart';
import 'package:evertask/view_models/single_tasksvm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// class TasksScreen extends StatefulWidget {
//   const TasksScreen({Key? key}) : super(key: key);

//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   Provider.of<SingleTasksVM>(context, listen: false).getData();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   Provider.of<SingleTasksVM>(context, listen: false).saveData();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    addNewTask() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const AddTaskScreen();
          },
        ),
      ).then(
        (value) {
          Provider.of<SingleTasksVM>(context, listen: false).addTask(value);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 500,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Сегодня',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              Text(
                DateFormat.MMMEd().format(DateTime.now()),
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            color: Colors.grey,
            onPressed: addNewTask,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Provider.of<SingleTasksVM>(context).singleTasksForNow.isEmpty ? buildNoTasksWidget(context, addNewTask) : ListView(
          children: [
            if (Provider.of<SingleTasksVM>(context).singleTasks.isNotEmpty)
              buildSingleTasks(context),
          ],
        ),
      ),
    );
  }

  Widget buildSingleTasks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Единичные задачи',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
        ),
        const SingleTasksList()
      ],
    );
  }

  Widget buildNoTasksWidget(BuildContext context, addNewTask) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'На сегодня задач нет',
            style: Theme.of(context).textTheme.headline6,
          ),
          TextButton(
            child: const Text('Добавить задачу'),
            onPressed: addNewTask,
          )
        ],
      ),
    );
  }
}

// Consumer<Auth>(
//         builder: (ctx, auth, _) => MaterialApp(
//           title: 'MyShop',
//           theme: ThemeData(
//             primarySwatch: Colors.purple,
//             accentColor: Colors.deepOrange,
//             fontFamily: 'Lato',
//           ),
//           home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(future: auth.tryAutoLogin(), builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),),
//         ),
//       ),
