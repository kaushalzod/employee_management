import 'package:employee_app/core/resources/data_state.dart';
import 'package:employee_app/features/employee_managment/domain/entities/employee_entity.dart';
import 'package:employee_app/features/employee_managment/domain/repositories/employee_repo.dart';
import 'package:employee_app/features/employee_managment/domain/usecases/employee_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;

  EmployeeBloc(this._employeeRepository) : super(EmployeeLoading()) {
    on<FetchEmployees>(fetchEmployees);
    on<AddEmployee>(addEmployees);
    on<UpdateEmployee>(updateEmployees);
    on<DeleteEmployee>(deleteEmployees);
  }

  // Helper to get only the date part (year, month, day)
  DateTime dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  void fetchEmployees(FetchEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final FetchEmployeeUseCase fetchEmployeeUseCase =
        FetchEmployeeUseCase(_employeeRepository);
    final dataState = await fetchEmployeeUseCase.execute();

    if (dataState is DataSucess && dataState.data!.isNotEmpty) {
      final todayDate = dateOnly(DateTime.now());

      final currentEmployees = dataState.data!.where((emp) {
        final startDateOnly = dateOnly(emp.startDate);
        final endDateOnly = emp.endDate != null ? dateOnly(emp.endDate!) : null;

        // Current if:
        // 1. Start date is before or equal to today AND
        // 2. End date is either null or after or equal to today.
        return (startDateOnly.isBefore(todayDate) ||
                startDateOnly.isAtSameMomentAs(todayDate)) &&
            (endDateOnly == null ||
                endDateOnly.isAfter(todayDate) ||
                endDateOnly.isAtSameMomentAs(todayDate));
      }).toList();

      final previousEmployees = dataState.data!.where((emp) {
        final endDate = emp.endDate;
        if (endDate == null) return false;
        final endDateOnly = dateOnly(endDate);
        return endDateOnly.isBefore(todayDate);
      }).toList();

      final upcomingEmployees = dataState.data!.where((emp) {
        final startDateOnly = dateOnly(emp.startDate);
        // Upcoming if start date is after today.
        return startDateOnly.isAfter(todayDate);
      }).toList();

      print(currentEmployees);
      print(previousEmployees);
      print(upcomingEmployees);

      emit(EmployeeFetched(
          currentEmployees, previousEmployees, upcomingEmployees));
    } else if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    } else {
      emit(EmployeeFetched([], [], []));
    }
  }

  void addEmployees(AddEmployee event, Emitter<EmployeeState> emit) async {
    final AddEmployeeUseCase addEmployeeUseCase =
        AddEmployeeUseCase(_employeeRepository);
    final dataState = await addEmployeeUseCase.execute(event.employee);

    if (dataState is DataSucess && dataState.data != null) {
      add(FetchEmployees());
    }

    if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    }
  }

  void updateEmployees(
      UpdateEmployee event, Emitter<EmployeeState> emit) async {
    final UpdateEmployeeUseCase updateEmployeeUseCase =
        UpdateEmployeeUseCase(_employeeRepository);
    final dataState = await updateEmployeeUseCase.execute(event.employee);

    if (dataState is DataSucess && dataState.data != null) {
      add(FetchEmployees());
    }

    if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    }
  }

  void deleteEmployees(
      DeleteEmployee event, Emitter<EmployeeState> emit) async {
    final DeleteEmployeeUseCase deleteEmployeeUseCase =
        DeleteEmployeeUseCase(_employeeRepository);
    final dataState = await deleteEmployeeUseCase.execute(event.employee);

    if (dataState is DataSucess && dataState.data != null) {
      add(FetchEmployees());
    }

    if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    }
  }
}
