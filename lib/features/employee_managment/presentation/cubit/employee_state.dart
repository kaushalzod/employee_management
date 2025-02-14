part of 'employee_cubit.dart';

class EmployeeCubitState {
  final String employeeName;
  final String role;
  final String? startDate;
  final String? endDate;

  const EmployeeCubitState({
    this.employeeName = '',
    this.role = '',
    this.startDate,
    this.endDate,
  });

  EmployeeCubitState copyWith({
    String? employeeName,
    String? role,
    String? startDate,
    String? endDate,
  }) {
    return EmployeeCubitState(
      employeeName: employeeName ?? this.employeeName,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
