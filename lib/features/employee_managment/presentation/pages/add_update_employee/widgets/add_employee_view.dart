import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/widgets/common_appbar.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/action_buttons/back_cancel_button.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/action_buttons/employee_save_button.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/edit_enddate_textfield.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/edit_startdate_textfield.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/emp_name_textfield.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/role_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key, this.employeeEntity, this.onDelete});
  final EmployeeEntity? employeeEntity;
  final ValueChanged<EmployeeEntity>? onDelete;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonAppbar(
        title: "${employeeEntity != null ? 'Edit' : 'Add'} Employee Details",
        actions: [
          if (employeeEntity != null && employeeEntity?.id != null)
            IconButton(
              onPressed: () {
                onDelete?.call(employeeEntity!);
              },
              icon: SvgPicture.asset(ImagePath.delete),
            )
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      persistentFooterButtons: [
        Container(
          margin: MediaQuery.of(context).viewInsets,
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BackCancelButton(),
              EmployeeSaveButton(employeeEntity: employeeEntity),
            ],
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          spacing: 23,
          children: [
            // Employee Name Field with BlocSelector
            EmpNameTextfield(),
            // Role Selection using BlocSelector
            RoleSelectionField(),
            // Date Picker Row using BlocSelector
            Row(spacing: 16, children: [
              EditStartdateTextfield(),
              SvgPicture.asset(ImagePath.arrow),
              EditEnddateTextfield(),
            ])
          ],
        ),
      ),
    );
  }
}
