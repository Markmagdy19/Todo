import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:chatt/controllers/task_controller.dart';
import 'package:chatt/models/task.dart';
import 'package:chatt/ui/utils/theme.dart';

import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  String _selectedRepeat = 'None';

  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Add Task',
              style: headingStyle(context),
            ),
            InputField(
              hint: 'Enter title here',
              title: 'Title',
              // widget: Icon(Icons.access_alarm),
              controller: _titleEditingController,
            ),
            InputField(
              hint: 'Enter your Note',
              title: 'Note',
              // widget: Icon(Icons.access_alarm),
              controller: _noteController,
            ),
            InputField(
              hint: DateFormat.yMd().format(_selectedDate),
              title: 'Date',
              // widget: Icon(Icons.access_alarm),
              widget: IconButton(
                onPressed: () {
                  _getDatefromUser();
                },
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    hint: _startTime,
                    title: 'Start Time',
                    // widget: Icon(Icons.access_alarm),
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputField(
                    hint: _endTime,
                    title: 'End Time',
                    // widget: Icon(Icons.access_alarm),
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InputField(
                hint: '$_selectedRemind minutes early',
                title: 'Remind',
                // widgett: Icon(Icons.access_alarm),
                widget: Row(children: [
                  DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    items: remindList
                        .map<DropdownMenuItem<String>>(
                            (int e) => DropdownMenuItem<String>(
                                value: e.toString(),
                                child: Text(
                                  '$e',
                                  style: const TextStyle(color: Colors.white),
                                )))
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 30,
                    elevation: 4,
                    underline: Container(height: 0),
                    style: subTitleStyle(context),
                    onChanged: (String? newvalue) {
                      setState(() {
                        _selectedRemind = int.parse(newvalue!);
                      });
                    },
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ])),
            InputField(
                hint: _selectedRepeat,
                title: 'Repeat',
                // widgett: Icon(Icons.access_alarm),
                widget: Row(children: [
                  DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    items: repeatList
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                )))
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 30,
                    elevation: 4,
                    underline: Container(height: 0),
                    style: subTitleStyle(context),
                    onChanged: (String? newvalue) {
                      setState(() {
                        _selectedRepeat = newvalue!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ])),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                MyButton(
                  label: 'Create Task',
                  onTap: () {
                    _validateDate();
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 20,
            color: primaryClr,
          ),
        ),
        actions: const [
          CircleAvatar(
            child: Icon(Icons.person),
            radius: 20,
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  _validateDate() {
    print('Validate Date Called');
    if (_titleEditingController.text.isNotEmpty &&
        _noteController.text.isNotEmpty) {
      print('All Fields are Filled');
      _addTaskTodb();
      Navigator.pop(context);
    } else if (_titleEditingController.text.isEmpty ||
        _noteController.text.isEmpty) {
      Get.snackbar('required', 'All fields are required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red[400],
          isDismissible: true,
          icon: Icon(
            Icons.warning_rounded,
            color: Colors.red[400],
          ));
    } else {
      print('!!!!!!! ERROR !!!!!!!!');
    }
  }

  _addTaskTodb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
          title: _titleEditingController.text,
          note: _noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('$value');
    } catch (e) {
      print('Error !!!');
    }
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle(context),
        ),
        const SizedBox(
          height: 6,
        ),
        Wrap(
            children: List<Widget>.generate(
          3,
          (index) => GestureDetector(
            onTap: (() {
              setState(() {
                _selectedColor = index;
              });
            }),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : orangeClr,
                child: _selectedColor == index
                    ? const Icon(
                        Icons.done,
                        size: 20,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
        )),
      ],
    );
  }

  void _getDatefromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print('Date not picked');
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15)),
            ),
    );
    String _formattedTime = _pickedTime!.format(context);
    if (isStartTime)
      setState(() {
        _startTime = _formattedTime;
      });
    else if (!isStartTime)
      setState(() {
        _endTime = _formattedTime;
      });
    else {
      print('time cancelled or something is wrong');
    }
  }
}
