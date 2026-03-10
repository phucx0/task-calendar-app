class Task {
  String title;
  DateTime date;
  bool isHidden;

  Task({
    required this.title,
    required this.date,
    this.isHidden = false,
  });
}
