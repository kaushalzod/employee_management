import 'package:employee_app/features/employee_managment/presentation/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/delete_guide.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/employee_detail_tile.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/employee_type_divider.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDataLoaded extends StatelessWidget {
  const HomeDataLoaded(
      {super.key, required this.state, required this.scaffoldContext});
  final EmployeeState state;
  final BuildContext scaffoldContext;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              // Current Employees Section
              if ((state.currentEmpList ?? []).isNotEmpty) ...[
                EmployeeTypeDivider(title: EmpStrConst.curEmp),
                ...(state.currentEmpList ?? []).map(
                  (employee) => EmployeeTile(
                    employee,
                    onDelete: (val) => _onDelete.call(scaffoldContext, val),
                  ),
                ),
              ],

              // Previous Employees Section
              if ((state.previousEmployees ?? []).isNotEmpty) ...[
                EmployeeTypeDivider(title: EmpStrConst.prevEmp),
                ...(state.previousEmployees ?? []).map(
                  (employee) {
                    return EmployeeTile(
                      employee,
                      onDelete: (val) => _onDelete(scaffoldContext, val),
                    );
                  },
                ),
              ],

              // Upcoming Employees Section
              if ((state.upcomingEmpList ?? []).isNotEmpty) ...[
                EmployeeTypeDivider(title: EmpStrConst.upEmp),
                ...(state.upcomingEmpList ?? []).map(
                  (employee) {
                    return EmployeeTile(
                      employee,
                      onDelete: (val) => _onDelete(scaffoldContext, val),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        DeleteGuide()
      ],
    );
  }

  void _onDelete(BuildContext context, value) {
    context.read<EmployeeBloc>().add(DeleteEmployee(employee: value));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(EmpStrConst.deletedNote),
      action: SnackBarAction(
        label: EmpStrConst.undo,
        onPressed: () {
          context.read<EmployeeBloc>().add(AddEmployee(employee: value));
        },
      ),
    ));
  }
}
