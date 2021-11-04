import 'package:evertask/view/screens/menu_screen.dart';
import 'package:evertask/view/screens/tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const TasksScreen(),
    const MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff0A0A0A),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xff6D6D6D),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_rounded,
              size: 25,
            ),
            label: 'Задачи'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_rounded,
              size: 30,
            ),
            label: 'Меню'
          ),
        ],
      ),
    );
  }

  // Widget buildNavBar() {
  //   return CupertinoSliverNavigationBar(
  //     backgroundColor: Colors.white,
  //     leading: const Material(
  //         child: Center(
  //             child: Text(
  //       'Пн, 11 октября',
  //       style: TextStyle(color: Color(0xff6D6D6D), fontWeight: FontWeight.w700),
  //     ))),
  //     trailing: CupertinoButton(onPressed: () {}, child: Icon(Icons.add)),
  //     largeTitle: Text('Large Title'),
  //   );
  // }
}
