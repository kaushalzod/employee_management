import 'package:employee_app/features/employee_managment/data/datasource/employee_local_datasource.dart';
import 'package:employee_app/features/employee_managment/data/repositories/employee_repository_impl.dart';
import 'package:employee_app/features/employee_managment/domain/repositories/employee_repo.dart';
import 'package:employee_app/features/employee_managment/domain/usecases/employee_usecases.dart';
import 'package:employee_app/features/employee_managment/presentation/bloc/employee_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  // Dependencies
  getIt.registerSingleton<EmployeeLocalDataSource>(
      EmployeeLocalDataSourceImpl());
  getIt.registerSingleton<EmployeeRepository>(
      EmployeeRepositoryImpl(employeeLocalDataSource: getIt()));

  // Usecases
  getIt.registerSingleton<FetchEmployeeUseCase>(
    FetchEmployeeUseCase(getIt()),
  );
  getIt.registerSingleton<AddEmployeeUseCase>(
    AddEmployeeUseCase(getIt()),
  );
  getIt.registerSingleton<DeleteEmployeeUseCase>(
    DeleteEmployeeUseCase(getIt()),
  );
  getIt.registerSingleton<UpdateEmployeeUseCase>(
    UpdateEmployeeUseCase(getIt()),
  );

  // Bloc
  getIt.registerFactory(() => EmployeeBloc(getIt()));
}
