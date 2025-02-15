import 'package:employee_app/core/widgets/common_appbar.dart';
import 'package:employee_app/features/employee_managment/presentation/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/home_data_loaded.dart';
import 'package:employee_app/features/employee_managment/presentation/pages/home/widgets/home_floating_button.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/no_record_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEmployees extends StatelessWidget {
  const AllEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeBloc>().add(FetchEmployees());
    return Scaffold(
      appBar: CommonAppbar(title: EmpStrConst.empList),
      body: Builder(builder: (scaffoldContext) {
        return BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is EmployeeFetched) {
              if ((state.currentEmpList ?? []).isEmpty &&
                  (state.previousEmployees ?? []).isEmpty &&
                  (state.upcomingEmpList ?? []).isEmpty) {
                return NoRecordFound();
              }
              return HomeDataLoaded(
                state: state,
                scaffoldContext: scaffoldContext,
              );
            } else if (state is EmployeeError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Container();
          },
        );
      }),
      floatingActionButton: HomeFloatingButton(),
    );
  }
}
