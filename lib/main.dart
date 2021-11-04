// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:evertask/view/components/theme.dart';
import 'package:evertask/view/screens/home.dart';
import 'package:evertask/view_models/single_tasksvm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
// AwesomeNotifications().initialize(
//   'resource://drawable/res_notification_app_icon',
//   [
//     NotificationChannel(
//       channelKey: 'basic_channel',
//       channelName: 'Basic Notifications',
//       defaultColor: Colors.teal,
//       importance: NotificationImportance.High,
//       channelShowBadge: true,
//     ),
//   ],
// );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _singleTasksVM = SingleTasksVM();

  @override
  Widget build(BuildContext context) {
    final theme = TasksTheme.dark();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _singleTasksVM),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: const Home(),
      ),
    );
  }
}
