import 'package:flutter/material.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/models/task_list_model.dart';
import 'package:project/Data/models/task_model.dart';
import 'package:project/Data/models/task_status_count_model.dart';
import 'package:project/Data/models/task_status_model.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/ui/screens/add_new_task_screen.dart';
import 'package:project/ui/screens/completed_task_screen.dart';
import 'package:project/ui/utils/app_colors.dart';
import 'package:project/ui/widgets/TaskCard.dart';
import 'package:project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';
import 'package:project/ui/widgets/task_summery_card.dart';

import '../../Data/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _newTaskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getNewTaskList();
        _getTaskStatusCount();
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildSummerySection(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Visibility(
                  visible: !_getNewTaskInProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newTaskList[index],
                        onRefreshList: _getNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: _newTaskList.length,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTapAddFloatingActionB,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: !_getTaskStatusCountInProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _getTaskSummaryCardList()),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _newTaskStatusCountList) {
      taskSummaryCardList.add(
        TaskSummaryCard(title: t.sId!, count: t.sum ?? 0),
      );
    }
    return taskSummaryCardList;
  }

  Future<void> _onTapAddFloatingActionB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.newTaskList,
    );
    _getNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.resposeData,
      );
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskStatusCount,
    );
    _getTaskStatusCountInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.resposeData);
      _newTaskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
