import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  int? id;
  final String employeeName;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  Employee({
    this.id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeName: json['employeeName'],
      role: json['role'],
      startDate: DateTime.fromMillisecondsSinceEpoch(json['startDate']),
      endDate: json['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['endDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'role': role,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory Employee.fromEntity(EmployeeEntity entity) {
    return Employee(
      id: entity.id,
      role: entity.role,
      employeeName: entity.employeeName,
      startDate: entity.startDate,
      endDate: entity.endDate,
    );
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      employeeName: employeeName,
      role: role,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  List<Object?> get props => [id, employeeName, role, startDate, endDate];
}
