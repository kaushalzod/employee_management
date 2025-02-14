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

  void fetchEmployees(FetchEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final FetchEmployeeUseCase fetchEmployeeUseCase =
        FetchEmployeeUseCase(_employeeRepository);
    final dataState = await fetchEmployeeUseCase.execute();

    if (dataState is DataSucess && dataState.data!.isNotEmpty) {
      final today = DateTime.now();

      final currentEmployees = dataState.data!.where((emp) {
        final startDate = emp.startDate;
        final endDate = emp.endDate;
        return startDate.isBefore(today) &&
            (endDate == null || endDate.isAfter(today));
      }).toList();

      final previousEmployees = dataState.data!.where((emp) {
        final endDate = emp.endDate;
        return endDate != null && endDate.isBefore(today);
      }).toList();

      emit(EmployeeFetched(currentEmployees, previousEmployees));
    } else if (dataState is DataFailed) {
      emit(EmployeeError(dataState.error!));
    } else {
      emit(EmployeeFetched([], []));
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
