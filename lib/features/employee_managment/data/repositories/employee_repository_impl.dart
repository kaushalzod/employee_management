import 'package:employee_app/core/resources/data_state.dart';
import 'package:employee_app/features/employee_managment/data/datasource/employee_local_datasource.dart';
import 'package:employee_app/features/employee_managment/data/model/employee.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/domain/repositories/employee_repo.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeLocalDataSource employeeLocalDataSource;

  EmployeeRepositoryImpl({required this.employeeLocalDataSource});

  @override
  Future<DataState<List<EmployeeEntity>>> fetchEmployees() async {
    try {
      final employees = await employeeLocalDataSource.fetch();
      return DataSucess(employees.map((e) => e.toEntity()).toList());
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<EmployeeEntity>> addEmployee(EmployeeEntity employee) async {
    try {
      final employees =
          await employeeLocalDataSource.add(Employee.fromEntity(employee));
      return DataSucess(employees.toEntity());
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<EmployeeEntity>> deleteEmployee(int id) async {
    try {
      final employees = await employeeLocalDataSource.delete(id);
      return DataSucess(employees.toEntity());
    } on DatabaseException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<EmployeeEntity>> editEmployee(
      EmployeeEntity employee) async {
    try {
      final employees =
          await employeeLocalDataSource.update(Employee.fromEntity(employee));
      return DataSucess(employees.toEntity());
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
