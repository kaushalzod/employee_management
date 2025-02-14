import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/widgets/add_employee_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateEmployeePage extends StatelessWidget {
  const AddUpdateEmployeePage({super.key, this.employeeEntity, this.onDelete});
  final EmployeeEntity? employeeEntity;
  final ValueChanged<EmployeeEntity>? onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit()..addAllData(employeeEntity),
      child: AddEmployeeView(
        employeeEntity: employeeEntity,
        onDelete: onDelete,
      ),
    );
  }
}
