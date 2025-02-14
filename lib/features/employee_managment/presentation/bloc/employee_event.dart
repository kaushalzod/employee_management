part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class AddEmployee extends EmployeeEvent {
  final EmployeeEntity employee;
  const AddEmployee({required this.employee});
}

class FetchEmployees extends EmployeeEvent {}

class DeleteEmployee extends EmployeeEvent {
  final EmployeeEntity employee;
  const DeleteEmployee({
    required this.employee,
  });
}

class UpdateEmployee extends EmployeeEvent {
  final EmployeeEntity employee;
  const UpdateEmployee({required this.employee});
}
