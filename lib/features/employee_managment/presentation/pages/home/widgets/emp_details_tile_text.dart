import 'package:employee_app/core/constant/theme_color.dart';
import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';

class EmpDetailsTileText extends StatelessWidget {
  const EmpDetailsTileText({super.key, required this.employee});
  final EmployeeEntity employee;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employee.employeeName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          employee.role,
          style: TextStyle(color: ThemeColor.lightText, fontSize: 14),
        ),
        Row(
          children: [
            if (employee.endDate == null)
              Text(
                EmpStrConst.from,
                style: TextStyle(color: ThemeColor.lightText),
              ),
            Text(
              employee.startDate.toString().dateFormat,
              style: TextStyle(color: ThemeColor.lightText, fontSize: 14),
            ),
            if (employee.endDate != null)
              Text(
                " - ${employee.endDate.toString().dateFormat}",
                style: TextStyle(color: ThemeColor.lightText, fontSize: 14),
              ),
          ],
        )
      ],
    );
  }
}
