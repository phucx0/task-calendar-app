import 'package:flutter/material.dart';
import 'app_colors.dart';

class DatePickerField extends StatefulWidget {
  final Function(DateTime) onSelected;
  final DateTime? initialDate;

  const DatePickerField({
    super.key,
    required this.onSelected,
    this.initialDate,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialDate;
  }

  Future<void> pickDateTime() async {
    final DateTime now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: selected ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
      errorFormatText: 'Định dạng ngày không hợp lệ',
      errorInvalidText: 'Ngày ngoài khoảng cho phép',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: selected != null
          ? TimeOfDay(hour: selected!.hour, minute: selected!.minute)
          : TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return;

    final result = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => selected = result);
    widget.onSelected(result);
  }

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
    return GestureDetector(
      onTap: pickDateTime,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              selected == null ? "Chọn ngày và giờ" : _formatDate(selected!),
              style: TextStyle(
                color: selected == null ? AppColors.grey : AppColors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
