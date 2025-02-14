import 'package:employee_app/core/constant/theme_color.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';

class DeleteGuide extends StatelessWidget {
  const DeleteGuide({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: ThemeColor.border),
      padding: const EdgeInsets.only(top: 12, left: 16),
      height: 76,
      child: Text(
        EmpStrConst.deleteGuide,
        style: TextStyle(color: ThemeColor.lightText),
      ),
    );
  }
}
