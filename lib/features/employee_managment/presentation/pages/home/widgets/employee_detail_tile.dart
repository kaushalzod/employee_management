import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/constant/theme_color.dart';
import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/add_update_employee.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/emp_details_tile_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class EmployeeTile extends StatelessWidget {
  final EmployeeEntity employee;
  const EmployeeTile(this.employee, {super.key, this.onDelete});
  final ValueChanged<EmployeeEntity>? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(employee.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.2,
        children: [
          InkWell(
            onTap: () => onDelete?.call(employee),
            child: Container(
              width: 72,
              color: Colors.red,
              alignment: Alignment.center,
              child: SvgPicture.asset(ImagePath.delete),
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(AddUpdateEmployeePage(
            employeeEntity: employee,
            onDelete: (value) {
              Navigator.pop(context);
              onDelete?.call(value);
            },
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ThemeColor.divider)),
          ),
          padding: const EdgeInsets.all(16),
          child: EmpDetailsTileText(employee: employee),
        ),
      ),
    );
  }
}
