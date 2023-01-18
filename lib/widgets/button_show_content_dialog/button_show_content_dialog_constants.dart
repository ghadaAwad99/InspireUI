part of '../button_show_content_dialog_widget.dart';

class ButtonDialogKeys {
  static const String item = 'dropdown_widget_';
  static const String arrow = 'dropdown_widget_arrow_Button';
  static const String labelDefault = 'dropdown_widget_labelDefault_Button';
}

class ButtonDialogConstants {
  static const double arrowPaddingRight = 12;
  static const double arrowPaddingTop = 16;

  static const double borderWidth = 1;
  static const double borderRadius = 10;
  static const int countItemExpandDefault = 3;
}

enum DropDownExpandType {
  down,
  up,
  center,
}

class ButtonDialogItem {
  final Key? key;
  final String? id;
  final String value;
  ButtonDialogItem({
    this.key,
    this.id,
    required this.value,
  });
  @override
  String toString() {
    return '$id | $value';
  }
}
