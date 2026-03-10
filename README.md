# Task Calendar App

Ứng dụng quản lý công việc đơn giản được xây dựng bằng Flutter.
Người dùng có thể thêm công việc, chọn ngày thực hiện và xem danh sách task.

## Features

* Thêm công việc
* Chọn ngày bằng Date Picker
* Hiển thị danh sách công việc
* UI đơn giản theo Material Design

## Project Structure

```
lib/
 ├── controllers/
 │   └── task_controller.dart
 │
 ├── models/
 │   └── task.dart
 │
 ├── screens/
 │   └── home_screen.dart
 │
 ├── widgets/
 │   ├── app_colors.dart
 │   ├── custom_appbar.dart
 │   ├── date_picker_field.dart
 │   ├── task_card.dart
 │   └── task_form_dialog.dart
 │
 └── main.dart
```

### Folder Description

* **controllers**: xử lý logic quản lý task
* **models**: định nghĩa dữ liệu (Task model)
* **screens**: các màn hình của ứng dụng
* **widgets**: các widget tái sử dụng

## Getting Started

Clone project

```
git clone https://github.com/phucx0/task-calendar-app.git
```

Install dependencies

```
flutter pub get
```

Run app

```
flutter run
```

## Tech Stack

* Flutter
* Dart
* Material UI
