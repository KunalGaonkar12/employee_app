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

//To delete employee
@immutable
class EmployeeEventDelete implements EmployeeEvent {
  final Employee employee;

  const EmployeeEventDelete({
    required this.employee,
  }) : super();
}

//To go to add employee view
@immutable
class EmployeeEventGoToAdd implements EmployeeEvent {
  const EmployeeEventGoToAdd();
}


//To set data from data base
@immutable
class EmployeeEventInitialize implements EmployeeEvent {
  const EmployeeEventInitialize();
}