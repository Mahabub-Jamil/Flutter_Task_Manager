import 'package:flutter/material.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/models/task_list_model.dart';
import 'package:project/Data/models/task_model.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/widgets/TaskCard.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _cancelledTaskList = [];
  static int length = 0;
  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return TaskCard(taskModel: _cancelledTaskList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: _cancelledTaskList.length,
      ),
    );
  }

  Future<void> _getCancelledTask() async {
    _cancelledTaskList.clear();
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
      _cancelledTaskList = taskListModel.taskList ?? [];
      length = _cancelledTaskList.length;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
