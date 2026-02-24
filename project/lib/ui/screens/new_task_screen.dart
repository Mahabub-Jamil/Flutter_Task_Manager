import 'package:flutter/material.dart';
import 'package:project/ui/screens/add_new_task_screen.dart';
import 'package:project/ui/utils/app_colors.dart';
import 'package:project/ui/widgets/TaskCard.dart';
import 'package:project/ui/widgets/task_summery_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummerySection(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddFloatingActionB,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SummeryCard(title: 'New', count: 08),
            SummeryCard(title: 'Completed', count: 3),
            SummeryCard(title: 'Cancelled', count: 5),
            SummeryCard(title: 'Progress', count: 5),
          ],
        ),
      ),
    );
  }

  void _onTapAddFloatingActionB() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }
}
