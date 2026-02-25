import 'package:flutter/material.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/models/task_list_model.dart';
import 'package:project/Data/models/task_model.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/widgets/TaskCard.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _progressTaskList = [];
  static int length = 0;
  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return TaskCard(taskModel: _progressTaskList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: _progressTaskList.length,
      ),
    );
  }

  Future<void> _getProgressTask() async {
    _progressTaskList.clear();
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.progressTaskList,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.resposeData,
      );
      _progressTaskList = taskListModel.taskList ?? [];
      length = _progressTaskList.length;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
