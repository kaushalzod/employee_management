import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/presentation/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/add_update_employee/add_update_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () async {
          final result = await context.push(AddUpdateEmployeePage());
          if (result == true && context.mounted) {
            context.read<EmployeeBloc>().add(FetchEmployees());
          }
        },
      ),
    );
  }
}
