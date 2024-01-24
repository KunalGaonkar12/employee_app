import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/data/repository/employee_repository.dart';
import 'package:employee_app/utils/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<EmployeeEventSelectOption>(employeeEventSelectOption);
    on<EmployeeEventOpenCalendar>(employeeEventOpenCalendar);
  }

  final repository = sl<EmployeeRepository>();

  final nameController = TextEditingController(text: '');
  final roleController = TextEditingController(text: '');
  final toDateController = TextEditingController();
  final fromDateController = TextEditingController();

  //to handle selection calendar options
  void employeeEventSelectOption(
      EmployeeEventSelectOption event, Emitter<EmployeeState> emit) {
    DateTime? date = state.selectedDate;

    date = DateTimeHelper.calculateDate(null, event.selectedOption);
    emit(EmployeeStateIsInAddDetailView(
      isProcessing: false,
      employee: state.employee,
      selectedDate: date,
      selectedOption: event.selectedOption,
    ));
  }

  //to handle date selection
  void employeeEventSelectDate(
      EmployeeEventSelectDate event, Emitter<EmployeeState> emit) {
    emit(EmployeeStateIsInAddDetailView(
        isProcessing: false,
        employee: state.employee,
        selectedDate: state.selectedDate));
  }

  //to handle data setting while opening calendar
  void employeeEventOpenCalendar(
      EmployeeEventOpenCalendar event, Emitter<EmployeeState> emit) {
    DateTime? selectedDate = DateTimeHelper.parseDateString(event.selectedDate);
    String selectedOption = '';
    if (selectedDate == null && event.length > 2) {
      selectedDate = DateTime.now();
      selectedOption = 'Today';
    } else if (selectedDate == null) {
      selectedDate = null;
      selectedOption = 'No date';
    }

    emit(EmployeeStateIsInAddDetailView(
        isProcessing: false,
        selectedOption: selectedOption,
        employee: state.employee,
        selectedDate: selectedDate));
  }

  //to handle deletion undo
  Future<void> employeeEventUndoDelete(
      EmployeeEventUndoDelete event, Emitter<EmployeeState> emit) async {
    final deletedEmployee = state.deletedEmployee;

    if (deletedEmployee != null) {
      await repository.saveEmployee(deletedEmployee);
    }

    final map = await categorizeEmployees();

    emit(EmployeeStateSaved(
      isProcessing: false,
      previousEmployees: map['previousEmployees'],
      currentEmployees: map['currentEmployees'],
    ));
  }

  //to handle deletion of data
  Future<void> employeeEventDelete(
      EmployeeEventDelete event, Emitter<EmployeeState> emit) async {
    try {
      final employee = event.employee;
      await repository.deleteEmployee(employee);

      final map = await categorizeEmployees();

      emit(EmployeeStateSaved(
        isProcessing: false,
        previousEmployees: map['previousEmployees'],
        currentEmployees: map['currentEmployees'],
        status: Status.deleted.message,
        deletedEmployee: employee,
      ));
    } catch (e) {
      throw e;
    }
  }

  //to handle navigation to add detail screen and setting data id edit screen
  void employeeEventGoToAdd(
      EmployeeEventGoToAdd event, Emitter<EmployeeState> emit) {
    final employee = event.employee;

    if (employee != null) {
      nameController.text = employee.name;
      roleController.text = employee.role;
      fromDateController.text = employee.fromDate;
      toDateController.text = employee.toDate ?? '';
    } else {
      clearControllers();
      fromDateController.text = 'Today';
    }

    emit(EmployeeStateIsInAddDetailView(
        isProcessing: false,
        selectedDate: state.selectedDate,
        employee: employee));
  }

  //to handle navigation to employee list screen
  Future<void> employeeEventGoToEmployeeList(
      EmployeeEventGoToEmployeeList event, Emitter<EmployeeState> emit) async {
    try {
      final map = await categorizeEmployees();

      emit(EmployeeStateSaved(
        isProcessing: false,
        previousEmployees: map['previousEmployees'],
        currentEmployees: map['currentEmployees'],
      ));
      clearControllers();
    } catch (e) {
      emit(EmployeeStateSaved(
          isProcessing: false, status: Status.unknown.message));
    }
  }

  //To handle data initially when the app is opened
  Future<void> employeeEventInitialize(
      EmployeeEventInitialize event, Emitter<EmployeeState> emit) async {
    try {
      final map = await categorizeEmployees();

      emit(EmployeeStateSaved(
        isProcessing: false,
        previousEmployees: map['previousEmployees'],
        currentEmployees: map['currentEmployees'],
      ));
    } catch (e) {
      emit(EmployeeStateSaved(
          isProcessing: false, status: Status.unknown.message));
    }
  }

  //To handle validation,saving and editing of employee data
  Future<void> employeeEventSave(
      EmployeeEventSave event, Emitter<EmployeeState> emit) async {
    final oldEmployeeData = state.employee;

    final validationMessage = validateEmployeeData();

    if (validationMessage.isNotEmpty) {
      emit(EmployeeStateIsInAddDetailView(
          isProcessing: false,
          selectedDate: state.selectedDate,
          errorMessage: validationMessage,
          employee: oldEmployeeData));
    } else {
      try {
        List<Employee> employeeRecords = await repository.getEmployeeRecords();
        final employee = event.employee;

        //Setting employee type
        employee.type = setEmployeeType(event.employee);
        if (employee.fromDate == 'Today') {
          employee.fromDate = DateTimeHelper.formatDateTime(DateTime.now());
        }

        //to set old employee id so the employee is updated
        if (oldEmployeeData != null) {
          employee.id = oldEmployeeData.id;
        }

        if (employeeRecords.isEmpty) {
          await repository.saveEmployee(employee);
        } else {
          int index = employeeRecords
              .indexWhere((element) => element.id == employee.id);
          if (index < 0) {
            await repository.saveEmployee(employee);
          } else {
            await repository.updateEmployee(employee);
          }
        }

        final map = await categorizeEmployees();

        emit(EmployeeStateSaved(
          isProcessing: false,
          previousEmployees: map['previousEmployees'],
          currentEmployees: map['currentEmployees'],
        ));
        clearControllers();
      } catch (e) {
        emit(EmployeeStateSaved(
            isProcessing: false, status: Status.unknown.message));
      }
    }
  }

  //To set employee type
  EmployeeType setEmployeeType(Employee employee) =>
      (employee.toDate != null && employee.toDate!.isNotEmpty)
          ? employee.type = EmployeeType.previousEmployee
          : employee.type = EmployeeType.currentEmployee;

  //To clear text controllers
  void clearControllers() {
    nameController.clear();
    roleController.clear();
    toDateController.clear();
    fromDateController.clear();
  }

//To categorize employees
  Future<Map<String, List<Employee>>> categorizeEmployees() async {
    final employeeRecords = await repository.getEmployeeRecords();
    Map<String, List<Employee>> categorizedMap = {
      'currentEmployees': [],
      'previousEmployees': [],
    };

    for (Employee employee in employeeRecords) {
      if (employee.type == EmployeeType.currentEmployee) {
        categorizedMap['currentEmployees']!.add(employee);
      } else if (employee.type == EmployeeType.previousEmployee) {
        categorizedMap['previousEmployees']!.add(employee);
      }
    }

    return categorizedMap;
  }

  //To validate mandatory  fields
  String validateEmployeeData() {
    if (nameController.text.isEmpty) {
      return 'Employee Name cannot be empty';
    } else if (roleController.text.isEmpty) {
      return 'Employee Role cannot be empty';
    } else if (fromDateController.text.isEmpty) {
      return 'From date cannot be empty';
    } else if (fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty) {
      final fromDateString = fromDateController.text;

      //to get from date in DateTime format
      final fromDate = DateTimeHelper.parseDateString(fromDateString == "Today"
          ? DateTimeHelper.formatDateTime(DateTime.now())
          : fromDateString);

      final toDate = DateTimeHelper.parseDateString(toDateController.text);
      if (!DateTimeHelper.isDateRangeValid(fromDate!, toDate!)) {
        return 'To date cannot be greater than from date';
      }
    }

    return '';
  }
}
