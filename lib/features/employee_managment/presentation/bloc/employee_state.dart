part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  final List<EmployeeEntity>? currentEmpList;
  final List<EmployeeEntity>? previousEmployees;
  final List<EmployeeEntity>? upcomingEmpList;
  final String? error;
  const EmployeeState(
      {this.currentEmpList,
      this.previousEmployees,
      this.error,
      this.upcomingEmpList});

  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {}

class EmployeeFetched extends EmployeeState {
  const EmployeeFetched(
    List<EmployeeEntity> currentEmpList,
    List<EmployeeEntity> previousEmpList,
    List<EmployeeEntity> upcomingEmpList,
  ) : super(
          currentEmpList: currentEmpList,
          previousEmployees: previousEmpList,
          upcomingEmpList: upcomingEmpList,
        );
}

class EmployeeError extends EmployeeState {
  const EmployeeError(String error) : super(error: error);
}
