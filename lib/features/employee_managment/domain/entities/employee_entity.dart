import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int? id;
  final String employeeName;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  const EmployeeEntity({
    this.id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [employeeName, role, startDate, endDate];
}
