import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class EmployeeEvent {
  const EmployeeEvent();
}

//To add and update employee
@immutable
class EmployeeEventSave implements EmployeeEvent {
  final Employee employee;

  const EmployeeEventSave({
    required this.employee,
  }) : super();
}

//To add employee
@immutable
class EmployeeEventEdit implements EmployeeEvent {
  final Employee employee;

  const EmployeeEventEdit({
    required this.employee,
  }) : super();
}

//To delete employee
@immutable
class EmployeeEventDelete implements EmployeeEvent {
  final Employee employee;

  const EmployeeEventDelete({
    required this.employee,
  }) : super();
}

//To delete employee
@immutable
class EmployeeEventUndoDelete implements EmployeeEvent {
  const EmployeeEventUndoDelete() : super();
}

//To go to add employee view
@immutable
class EmployeeEventGoToAdd implements EmployeeEvent {
  final Employee? employee;
  const EmployeeEventGoToAdd({this.employee});
}

//To go to add employee view
@immutable
class EmployeeEventGoToEmployeeList implements EmployeeEvent {
  const EmployeeEventGoToEmployeeList():super();
}

//To set data from data base
@immutable
class EmployeeEventInitialize implements EmployeeEvent {
  const EmployeeEventInitialize():super();
}

//To set data from data base
@immutable
class EmployeeEventSelectDate implements EmployeeEvent {
  const EmployeeEventSelectDate():super();
}
