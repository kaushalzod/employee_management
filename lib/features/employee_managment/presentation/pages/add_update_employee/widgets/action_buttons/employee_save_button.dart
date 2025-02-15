import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/presentation/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeSaveButton extends StatelessWidget {
  const EmployeeSaveButton({super.key, required this.employeeEntity});
  final EmployeeEntity? employeeEntity;
  @override
  Widget build(BuildContext context) {
    return ActionButton(
      title: EmpStrConst.save,
      onTap: () {
        final employeeCubit = context.read<EmployeeCubit>();

        if (!employeeCubit.validateFields()) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please fill all required field")));
          return;
        }

        final employee = EmployeeEntity(
          id: employeeEntity?.id,
          employeeName: employeeCubit.state.employeeName,
          role: employeeCubit.state.role,
          startDate: DateTime.parse(employeeCubit.state.startDate!),
          endDate: DateTime.tryParse(employeeCubit.state.endDate ?? ""),
        );
        if (employeeEntity == null) {
          context.read<EmployeeBloc>().add(AddEmployee(employee: employee));
        } else {
          context.read<EmployeeBloc>().add(UpdateEmployee(employee: employee));
        }
        context.pop();
      },
    );
  }
}
