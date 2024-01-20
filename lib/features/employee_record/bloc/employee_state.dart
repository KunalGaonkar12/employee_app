import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../confic/enum/enum.dart';

@immutable
abstract class EmployeeState {
  final bool isProcessing;
  final Status? status;

  const EmployeeState({
    required this.isProcessing,
    this.status,
  });
}

@immutable
class EmployeeStateSaved extends EmployeeState {
  final List<Employee>? currentEmployees;
  final List<Employee>? previousEmployees;

  const EmployeeStateSaved({
    required bool isProcessing,
    Status? status,
    this.currentEmployees,
    this.previousEmployees,
  }) : super(isProcessing: isProcessing, status: status);
}

@immutable
class EmployeeStateSaving extends EmployeeState {
  const EmployeeStateSaving({
    required bool isProcessing,
  }) : super(
          isProcessing: isProcessing,
        );
}

@immutable
class EmployeeStateIsInAddDetailView extends EmployeeState {
  const EmployeeStateIsInAddDetailView({
    required bool isProcessing,
  }) : super(
          isProcessing: isProcessing,
        );
}
