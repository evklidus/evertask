import 'package:evertask/models/single_task.dart';
import 'package:evertask/models/subtask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:io' show Platform;

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';

  String? _subtitle;

  List<Subtask>? _subtasks;

  DateTime _selectedDate = DateTime.now();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    // FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      if (_subtasks != null) {
        _subtasks!.removeWhere((sub) => sub.title == '');
      }
      var newTask = SingleTask(
        title: _title,
        subtitle: _subtitle == '' ? null : _subtitle,
        subtasks: _subtasks == [] ? null : _subtasks,
        startDate: _selectedDate,
      );
      Navigator.of(context).pop(newTask);
    }
  }

  void _presentDatePicker() {
    // if (Platform.isAndroid) {
      showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    // } else {}
  }

  deleteSubtask(Subtask deletedSubtask) {
    setState(() {
      _subtasks!.removeWhere((subtask) => subtask.id == deletedSubtask.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(true),
                  buildTextField(false),
                  Text(
                    'Подзадачи',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (_subtasks != null)
                    ..._subtasks!
                        .map((subtask) => buildSubtask(subtask))
                        .toList(),
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      autofocus: true,
                      child: const Text('+ Добавить подзадачу'),
                      onPressed: () {
                        setState(() {
                          if (_subtasks == null) {
                            _subtasks = [];
                            _subtasks!.add(Subtask(title: ''));
                          } else {
                            _subtasks!.add(Subtask(title: ''));
                          }
                        });
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Дата начала'),
                          TextButton(
                            child: Text(_selectedDate.day == DateTime.now().day
                                ? 'Сегодня'
                                : DateFormat.yMMMd().format(_selectedDate)),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 6,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xff0A0A0A),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: InkWell(
                  onTap: _trySubmit,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 7,
                      color: const Color(0xff1D1B29),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Text('Создать задачу'),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(bool isTitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: const Color(0xff1C1B21),
          borderRadius: BorderRadius.circular(20)),
      child: CupertinoTextFormFieldRow(
        style: const TextStyle(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        // autocorrect: true,
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value!.isEmpty) {
            isTitle ? 'Пожалуйста, введите название' : null;
          }
          return null;
        },
        placeholder: isTitle ? 'Название' : 'Заметка',
        onSaved: (value) {
          if (isTitle) {
            _title = value!;
          } else {
            _subtitle = value!;
          }
        },
      ),
    );
  }

  Widget buildSubtask(Subtask subtask) {
    return Dismissible(
        key: Key(subtask.id),
        direction: DismissDirection.endToStart,
        background: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              padding: const EdgeInsets.only(right: 10),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete_forever,
                  color: Colors.white, size: 30.0)),
        ),
        onDismissed: (direction) {
          deleteSubtask(subtask);
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('${task.title} dismissed')));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              color: const Color(0xff1C1B21),
              borderRadius: BorderRadius.circular(15)),
          child: CupertinoTextFormFieldRow(
            style: const TextStyle(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            // autocorrect: true,
            cursorColor: Colors.white,
            textCapitalization: TextCapitalization.words,
            placeholder: 'Подзадача',
            onSaved: (value) {
              _subtasks!.add(Subtask(title: value!));
            },
          ),
        ));
  }
}
