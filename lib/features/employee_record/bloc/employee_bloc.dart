import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/data/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../confic/enum/enum.dart';
import '../../../injection_container.dart';
import '../data/model/employee.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc()
      : super(const EmployeeStateSaved(
          isProcessing: false,
          currentEmployees: [],
          previousEmployees: [],
        )) {
    on<EmployeeEventInitialize>(employeeEventInitialize);
    on<EmployeeEventSave>(employeeEventSave);
    on<EmployeeEventGoToAdd>(employeeEventGoToAdd);
    on<EmployeeEventGoToEmployeeList>(employeeEventGoToEmployeeList);
    on<EmployeeEventDelete>(employeeEventDelete);
    on<EmployeeEventUndoDelete>(employeeEventUndoDelete);
    on<EmployeeEventSelectDate>(employeeEventSelectDate);
  }

  final repository = sl<EmployeeRepository>();


  void employeeEventSelectDate(EmployeeEventSelectDate event ,Emitter<EmployeeState> emit){
    emit(EmployeeStateIsInAddDetailView(
      isProcessing: false,
      // employee: state.employee,
    ));

  }


  Future<void> employeeEventUndoDelete(
      EmployeeEventUndoDelete event, Emitter<EmployeeState> emit) async {
    final deletedEmployee = state.deletedEmployee;

    if (deletedEmployee != null) {
      await repository.saveEmployee(deletedEmployee);
    }

    final employeeRecords = await repository.getEmployeeRecords();

    final currentEmployees = await getSpecificEmployeeType(
        EmployeeType.currentEmployee, employeeRecords);

    final previousEmployees = await getSpecificEmployeeType(
        EmployeeType.previousEmployee, employeeRecords);

    emit(EmployeeStateSaved(
      isProcessing: false,
      currentEmployees: currentEmployees,
      previousEmployees: previousEmployees,
    ));
  }

  //to handle deletion of data
  //to handle deletion of data
  Future<void> employeeEventDelete(
      EmployeeEventDelete event, Emitter<EmployeeState> emit) async {
    try {
      final employee = event.employee;
      await repository.deleteEmployee(employee);

      final employeeRecords = await repository.getEmployeeRecords();

      final currentEmployees = await getSpecificEmployeeType(
          EmployeeType.currentEmployee, employeeRecords);

      final previousEmployees = await getSpecificEmployeeType(
          EmployeeType.previousEmployee, employeeRecords);

      emit(EmployeeStateSaved(
        isProcessing: false,
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
        status: Status.deleted.message,
        deletedEmployee: employee,
      ));
    } catch (e) {
      throw e;
    }
  }

  //to handle navigation to add detail screen
  void employeeEventGoToAdd(
      EmployeeEventGoToAdd event, Emitter<EmployeeState> emit) {
    emit(EmployeeStateIsInAddDetailView(
      isProcessing: false,
      employee: event.employee,
      selectedToDate: state.toDate
    ));
  }

  //to handle navigation to employee list screen
  Future<void> employeeEventGoToEmployeeList(
      EmployeeEventGoToEmployeeList event, Emitter<EmployeeState> emit) async {
    //to be optimized
    try {
      final employeeRecords = await repository.getEmployeeRecords();

      final currentEmployees = await getSpecificEmployeeType(
          EmployeeType.currentEmployee, employeeRecords);

      final previousEmployees = await getSpecificEmployeeType(
          EmployeeType.previousEmployee, employeeRecords);

      emit(EmployeeStateSaved(
        isProcessing: false,
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeStateSaved(
          isProcessing: false, status: Status.unknown.message));
    }
  }

  //To handle data initially when the app is opened
  Future<void> employeeEventInitialize(
      EmployeeEventInitialize event, Emitter<EmployeeState> emit) async {
    try {
      final employeeRecords = await repository.getEmployeeRecords();

      final currentEmployees = await getSpecificEmployeeType(
          EmployeeType.currentEmployee, employeeRecords);

      final previousEmployees = await getSpecificEmployeeType(
          EmployeeType.previousEmployee, employeeRecords);

      emit(EmployeeStateSaved(
        isProcessing: false,
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeStateSaved(
          isProcessing: false, status: Status.unknown.message));
    }
  }

  //To handle saving and editing of employee data
  Future<void> employeeEventSave(
      EmployeeEventSave event, Emitter<EmployeeState> emit) async {

    final oldEmployeeData=state.employee;

    emit(const EmployeeStateSaving(isProcessing: true));

    try {
      List<Employee> employeeRecords = await repository.getEmployeeRecords();
      final employee = event.employee;

      //Setting employee type
      employee.type = setEmployeeType(event.employee);

      //to set old id so the employee is up dated
      if(oldEmployeeData!=null){
        employee.id=oldEmployeeData.id;
      }

      if (employeeRecords.isEmpty) {
        await repository.saveEmployee(employee);
      } else {
        int index =
            employeeRecords.indexWhere((element) => element.id == employee.id);
        if (index < 0) {
          await repository.saveEmployee(employee);
        } else {
          await repository.updateEmployee(employee);
        }
      }

      employeeRecords = await repository.getEmployeeRecords();

      final currentEmployees = await getSpecificEmployeeType(
          EmployeeType.currentEmployee, employeeRecords);

      final previousEmployees = await getSpecificEmployeeType(
          EmployeeType.previousEmployee, employeeRecords);

      emit(EmployeeStateSaved(
        isProcessing: false,
        previousEmployees: previousEmployees,
        currentEmployees: currentEmployees,
      ));
    } catch (e) {
      emit(EmployeeStateSaved(
          isProcessing: false, status: Status.unknown.message));
    }
  }

  //To set employee type
  EmployeeType setEmployeeType(Employee employee) => (employee.toDate != null)
      ? employee.type = EmployeeType.previousEmployee
      : employee.type = EmployeeType.currentEmployee;

  //To get differentiate current and previous employees
  Future<List<Employee>> getSpecificEmployeeType(
      EmployeeType employeeType, List<Employee> employeeRecords) async {
    final employees = employeeRecords
        .where((element) => element.type == employeeType)
        .toList();

    return employees;
  }
}
