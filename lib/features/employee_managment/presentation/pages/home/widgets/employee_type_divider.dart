import 'package:employee_app/core/constant/theme_color.dart';
import 'package:flutter/material.dart';

class EmployeeTypeDivider extends StatelessWidget {
  const EmployeeTypeDivider({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: ThemeColor.divider,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
