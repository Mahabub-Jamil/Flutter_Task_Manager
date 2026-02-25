import 'package:flutter/material.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/models/task_list_model.dart';
import 'package:project/Data/models/task_model.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/widgets/TaskCard.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _completedTaskList = [];
  static int length = 0;
  @override
  void initState() {
    super.initState();
    _getCompletedList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return TaskCard(taskModel: _completedTaskList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: _completedTaskList.length,
      ),
    );
  }

  Future<void> _getCompletedList() async {
    _completedTaskList.clear();
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.cancelledTaskList,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.resposeData,
      );
      _completedTaskList = taskListModel.taskList ?? [];
      length = _completedTaskList.length;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
