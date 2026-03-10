import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/task_form_dialog.dart';
import '../widgets/task_card.dart';
import '../widgets/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showHidden = false;

  void _openAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => TaskFormDialog(
        onSubmit: (title, date) {
          context.read<TaskController>().addTask(
                Task(title: title, date: date),
              );
        },
      ),
    );
  }

  void _openEditDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (_) => TaskFormDialog(
        task: task,
        onSubmit: (title, date) {
          context.read<TaskController>().updateTask(task, title, date);
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Xác nhận xóa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black),
        ),
        content: Text(
          "Bạn có chắc muốn xóa công việc \"${task.title}\" không?",
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Hủy",
              style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskController>().deleteTask(task);
              Navigator.pop(context);
            },
            child: const Text(
              "Xóa",
              style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskController(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF0F4F8),
            appBar: CustomAppBar(
              showHidden: _showHidden,
              onToggleShowHidden: () => setState(() => _showHidden = !_showHidden),
            ),
            body: Consumer<TaskController>(
              builder: (_, controller, __) {
                final List<Task> displayList = _showHidden
                    ? controller.tasks
                    : controller.visibleTasks;

                return Column(
                  children: [
                    _buildSummaryBar(controller),
                    Expanded(
                      child: displayList.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 8, bottom: 100),
                              itemCount: displayList.length,
                              itemBuilder: (_, i) {
                                final task = displayList[i];
                                return TaskCard(
                                  task: task,
                                  onEdit: () => _openEditDialog(context, task),
                                  onDelete: () => _confirmDelete(context, task),
                                  onToggleHidden: () =>
                                      controller.toggleHidden(task),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _openAddDialog(context),
              backgroundColor: AppColors.primary,
              elevation: 2,
              icon: const Icon(Icons.add, color: AppColors.white),
              label: const Text(
                "Thêm việc",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryBar(TaskController controller) {
    final total = controller.tasks.length;
    final visible = controller.visibleTasks.length;
    final hidden = controller.hiddenTasks.length;

    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _summaryChip(Icons.list_alt, "$total công việc"),
          if (hidden > 0) ...[
            const SizedBox(width: 16),
            _summaryChip(Icons.visibility, "$visible hiển thị"),
            const SizedBox(width: 16),
            _summaryChip(Icons.visibility_off, "$hidden đã ẩn"),
          ],
        ],
      ),
    );
  }

  Widget _summaryChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.white.withOpacity(0.85)),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.9),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Chưa có công việc nào",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Nhấn nút bên dưới để thêm công việc mới",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
