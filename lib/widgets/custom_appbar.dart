import 'package:flutter/material.dart';
import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showHidden;
  final VoidCallback onToggleShowHidden;

  const CustomAppBar({
    super.key,
    required this.showHidden,
    required this.onToggleShowHidden,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Quản lý công việc",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            showHidden ? Icons.visibility_off : Icons.visibility,
            color: AppColors.white,
          ),
          tooltip: showHidden ? "Ẩn công việc đã ẩn" : "Hiện công việc đã ẩn",
          onPressed: onToggleShowHidden,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
