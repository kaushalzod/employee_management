import 'package:employee_app/features/employee_managment/data/model/employee.dart';

import 'local_data/database_helper.dart';

abstract class EmployeeLocalDataSource {
  Future<List<Employee>> fetch();
  Future<Employee> add(Employee employee);
  Future<Employee> delete(int empId);
  Future<Employee> update(Employee employee);
}

class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<Employee> add(Employee employee) => _databaseHelper.add(employee);

  @override
  Future<List<Employee>> fetch() => _databaseHelper.fetch();

  @override
  Future<Employee> update(Employee employee) =>
      _databaseHelper.update(employee);

  @override
  Future<Employee> delete(int empId) => _databaseHelper.delete(empId);
}
