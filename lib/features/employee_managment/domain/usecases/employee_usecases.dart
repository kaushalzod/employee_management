import 'package:employee_app/core/resources/data_state.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/domain/repositories/employee_repo.dart';

class FetchEmployeeUseCase {
  final EmployeeRepository employeeRepository;
  FetchEmployeeUseCase(this.employeeRepository);

  Future<DataState<List<EmployeeEntity>>> execute() =>
      employeeRepository.fetchEmployees();
}

class AddEmployeeUseCase {
  final EmployeeRepository employeeRepository;
  AddEmployeeUseCase(this.employeeRepository);

  Future<DataState<EmployeeEntity>> execute(EmployeeEntity employeeEntity) =>
      employeeRepository.addEmployee(employeeEntity);
}

class DeleteEmployeeUseCase {
  final EmployeeRepository employeeRepository;
  DeleteEmployeeUseCase(this.employeeRepository);

  Future<DataState<EmployeeEntity>> execute(EmployeeEntity employeeEntity) =>
      employeeRepository.deleteEmployee(employeeEntity.id!);
}

class UpdateEmployeeUseCase {
  final EmployeeRepository employeeRepository;
  UpdateEmployeeUseCase(this.employeeRepository);

  Future<DataState<EmployeeEntity>> execute(EmployeeEntity employeeEntity) =>
      employeeRepository.editEmployee(employeeEntity);
}
