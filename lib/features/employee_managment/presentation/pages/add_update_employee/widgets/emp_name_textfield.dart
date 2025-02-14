import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/widgets/common_textfield.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmpNameTextfield extends StatelessWidget {
  const EmpNameTextfield({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmployeeCubit, EmployeeCubitState, String>(
      selector: (state) => state.employeeName,
      builder: (context, employeeName) {
        return CommonTextfield(
          placeholder: EmpStrConst.empName,
          prefixIcon: ImagePath.person,
          initialValue: employeeName,
          style: TextStyle(fontSize: 16),
          onChanged: (value) {
            context.read<EmployeeCubit>().updateEmployeeName(value);
          },
        );
      },
    );
  }
}
