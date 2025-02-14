import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeCubitState> {
  EmployeeCubit() : super(EmployeeCubitState());

  void updateEmployeeName(String name) {
    emit(state.copyWith(employeeName: name));
  }

  void updateRole(String role) {
    emit(state.copyWith(role: role));
  }

  void updateStartDate(String? date) {
    emit(state.copyWith(startDate: date));
  }

  void updateEndDate(String? date) {
    emit(state.copyWith(endDate: date));
  }

  void addAllData(EmployeeEntity? employee) {
    if (employee != null) {
      updateEmployeeName(employee.employeeName);
      updateRole(employee.role);
      updateStartDate(employee.startDate.toString());
      if (employee.endDate != null) updateEndDate(employee.endDate.toString());
    }
  }

  bool validateFields() {
    if (state.employeeName.isEmpty) {
      return false;
    }
    if (state.role.isEmpty) {
      return false;
    }
    if (state.startDate == null || state.startDate!.isEmpty) {
      return false;
    }
    return true;
  }
}
