import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  Check({Key? key, required this.complete, required this.mainTask}) : super(key: key);

  bool complete;
  
  bool mainTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mainTask ? 35 : 25,
      height: mainTask ? 35 : 25,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: complete ? Colors.white : null,
        borderRadius: BorderRadius.circular(mainTask ? 10 : 8),
        border: complete ? null : Border.all(color: Colors.white, width: mainTask ? 2.5 : 2)
      ),
      child: complete ? Icon(CupertinoIcons.check_mark, color: Colors.black, size: mainTask ? 22 : 16,) : null,
    );
  }
}
