import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/data/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../confic/enum/enum.dart';
import '../../../injection_container.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc()
      : super(const EmployeeStateSaved(
          isProcessing: false,
          currentEmployees: [],
          previousEmployees: [],
        )) {
    on<EmployeeEventInitialize>(employeeEventInitialize);
    on<EmployeeEventSave>(employeeEventSave);
  }

  //To handle data initially when the app is opened
  void employeeEventInitialize(event, emit) async {
    try {
      final employeeRecords =
          await sl<EmployeeRepository>().getEmployeeRecords();
      emit(EmployeeStateSaved(
        isProcessing: false,
        currentEmployees: employeeRecords,
        previousEmployees: employeeRecords,
      ));
    } catch (e) {
      emit(const EmployeeStateSaved(
          isProcessing: false, status: Status.unknown));
    }
  }

  //To handle saving and editing of employee data
  void employeeEventSave(
      EmployeeEventSave event, Emitter<EmployeeState> emit) async {
    emit(const EmployeeStateSaving(isProcessing: true));
    final repository = sl<EmployeeRepository>();
    try {
      final employeeRecords = await repository.getEmployeeRecords();

      if (employeeRecords.isEmpty) {
        await repository.saveEmployee(event.employee);
      } else {
        int index =
            employeeRecords.indexWhere((element) => element == event.employee);
        if (index < 0) {
          await repository.saveEmployee(event.employee);
        } else {
          await repository.updateEmployee(event.employee);
        }
      }

      emit(EmployeeStateSaved(
        isProcessing: false,
        previousEmployees: employeeRecords,
        currentEmployees: employeeRecords,
      ));
    } catch (e) {
      emit(const EmployeeStateSaved(
          isProcessing: false, status: Status.unknown));
    }
  }
}
