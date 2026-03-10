import 'package:flutter/material.dart';
import '../models/task.dart';
import 'app_colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleHidden;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleHidden,
  });

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return "$day/$month/$year  $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    final bool isHidden = task.isHidden;

    return Opacity(
      opacity: isHidden ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.greyBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isHidden ? AppColors.greyLight : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isHidden ? Icons.visibility_off_outlined : Icons.task_alt,
                  color: isHidden ? AppColors.grey : AppColors.primary,
                  size: 20,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isHidden ? AppColors.grey : AppColors.black,
                        decoration: isHidden ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 13,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(task.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: AppColors.grey, size: 20),
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.greyBorder),
                ),
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'hide') onToggleHidden();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: const [
                        Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
                        SizedBox(width: 10),
                        Text("Chỉnh sửa", style: TextStyle(fontSize: 14, color: AppColors.black)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'hide',
                    child: Row(
                      children: [
                        Icon(
                          isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isHidden ? "Hiện lại" : "Ẩn",
                          style: const TextStyle(fontSize: 14, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: const [
                        Icon(Icons.delete_outline, size: 16, color: AppColors.danger),
                        SizedBox(width: 10),
                        Text("Xóa", style: TextStyle(fontSize: 14, color: AppColors.danger)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
