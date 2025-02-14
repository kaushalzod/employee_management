import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExt on BuildContext {
  Future push(Widget child) => Navigator.of(this).push(
        MaterialPageRoute(builder: (context) => child),
      );
  void pop() => Navigator.pop(this);
}

extension StringExt on String {
  get dateFormat => DateFormat('d MMM yyyy').format(DateTime.parse(this));
}
