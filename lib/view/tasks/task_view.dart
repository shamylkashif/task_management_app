import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../../models/task.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';

class TaskView extends StatefulWidget {
  TaskView({
    Key? key,
    required this.taskControllerForTitle,
    required this.taskControllerForSubtitle,
    required this.task,
  }) : super(key: key);

  TextEditingController? taskControllerForTitle;
  TextEditingController? taskControllerForSubtitle;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      return DateFormat('hh:mm a').format(time ?? DateTime.now());
    } else {
      return DateFormat('hh:mm a').format(widget.task!.createdAtTime);
    }
  }

  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      return time ?? DateTime.now();
    } else {
      return widget.task!.createdAtTime;
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      return DateFormat.yMMMEd().format(date ?? DateTime.now());
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate);
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      return date ?? DateTime.now();
    } else {
      return widget.task!.createdAtDate;
    }
  }

  bool isTaskAlreadyExistBool() {
    return widget.task != null;
  }

  dynamic isTaskAlreadyExistUpdateTask() {
    if (title != null && subtitle != null) {
      if (isTaskAlreadyExistBool()) {
        widget.taskControllerForTitle?.text = title;
        widget.taskControllerForSubtitle?.text = subtitle;
        widget.task?.save();
      } else {
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subtitle: subtitle,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
      }
      Navigator.of(context).pop();
    } else {
      emptyFieldsWarning(context);
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 24, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            if (isTaskAlreadyExistBool())
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
              ),
          ],
          centerTitle: true,
          title: Text(
            isTaskAlreadyExistBool()
                ? MyString.updateCurrentTask + MyString.taskStrnig
                : MyString.addNewTask + MyString.taskStrnig,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildMiddleTextFieldsANDTimeAndDateSelection(
                      context, textTheme),
                  _buildBottomButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExistBool()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          if (isTaskAlreadyExistBool())
            Container(
              width: 150,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minWidth: 150,
                height: 55,
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
                color: Colors.white,
                child: Row(
                  children: const [
                    Icon(Icons.close, color: MyColors.primaryColor),
                    SizedBox(width: 5),
                    Text(MyString.deleteTask,
                        style: TextStyle(color: MyColors.primaryColor)),
                  ],
                ),
              ),
            ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minWidth: 150,
            height: 55,
            onPressed: () => isTaskAlreadyExistUpdateTask(),
            color: MyColors.primaryColor,
            child: Text(
              isTaskAlreadyExistBool()
                  ? MyString.updateTaskString
                  : MyString.addTaskString,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildMiddleTextFieldsANDTimeAndDateSelection(
      BuildContext context, TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(MyString.titleOfTitleTextField,
                style: textTheme.headlineMedium),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: TextFormField(
                controller: widget.taskControllerForTitle,
                maxLines: 6,
                cursorHeight: 60,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
                onChanged: (value) => title = value,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: TextFormField(
                controller: widget.taskControllerForSubtitle,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon:
                  const Icon(Icons.bookmark_border, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: MyString.addNote,
                ),
                onChanged: (value) => subtitle = value,
              ),
            ),
          ),
          _buildDateTimePicker(
              context, textTheme, MyString.timeString, showTime(time)),
          _buildDateTimePicker(
              context, textTheme, MyString.dateString, showDate(date)),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context, TextTheme textTheme,
      String label, String value) {
    final isTime = label.toLowerCase().contains('time');

    return GestureDetector(
      onTap: () async {
        if (isTime) {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(time ?? DateTime.now()),
          );
          if (selectedTime != null) {
            final now = DateTime.now();
            setState(() {
              time = DateTime(now.year, now.month, now.day,
                  selectedTime.hour, selectedTime.minute);
            });
          }
        } else {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (selectedDate != null) {
            setState(() {
              date = selectedDate;
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(label, style: textTheme.headlineSmall),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(value, style: textTheme.titleSmall)),
            )
          ],
        ),
      ),
    );
  }

}
