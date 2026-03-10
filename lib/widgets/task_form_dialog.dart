import 'package:flutter/material.dart';
import '../models/task.dart';
import 'date_picker_field.dart';
import 'app_colors.dart';

class TaskFormDialog extends StatefulWidget {
  final Task? task;
  final Function(String title, DateTime date) onSubmit;

  const TaskFormDialog({
    super.key,
    this.task,
    required this.onSubmit,
  });

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  late final TextEditingController _titleController;
  DateTime? _selectedDate;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _selectedDate = widget.task?.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty || _selectedDate == null) return;
    widget.onSubmit(_titleController.text.trim(), _selectedDate!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.task_alt,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _isEditing ? "Chỉnh sửa công việc" : "Thêm công việc",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Tên công việc",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(fontSize: 14, color: AppColors.black),
              decoration: InputDecoration(
                hintText: "Nhập tên công việc...",
                hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 18),
                filled: true,
                fillColor: AppColors.greyLight,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Ngày và giờ",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            DatePickerField(
              onSelected: (date) => setState(() => _selectedDate = date),
              initialDate: _selectedDate,
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.greyBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _isEditing ? "Lưu" : "Thêm",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
