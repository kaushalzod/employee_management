import 'package:employee_app/core/resources/data_state.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<DataState<EmployeeEntity>> addEmployee(EmployeeEntity employee);
  Future<DataState<List<EmployeeEntity>>> fetchEmployees();
  Future<DataState<EmployeeEntity>> deleteEmployee(int id);
  Future<DataState<EmployeeEntity>> editEmployee(EmployeeEntity employee);
}
