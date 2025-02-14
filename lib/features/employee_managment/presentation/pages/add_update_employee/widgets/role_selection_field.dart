import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/widgets/common_textfield.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/role_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleSelectionField extends StatelessWidget {
  const RoleSelectionField({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmployeeCubit, EmployeeCubitState, String>(
      selector: (state) => state.role,
      builder: (context, role) {
        return CommonTextfield(
          controller: TextEditingController(text: role),
          placeholder: role.isEmpty ? EmpStrConst.selRole : role,
          prefixIcon: ImagePath.work,
          sufixIcon: ImagePath.dropDown,
          style: TextStyle(fontSize: 16),
          readOnly: true,
          onTap: () {
            RoleBottomsheet.open(
              context,
              onTap: (title) {
                context.read<EmployeeCubit>().updateRole(title);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
