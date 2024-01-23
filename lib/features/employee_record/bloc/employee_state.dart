import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../confic/enum/enum.dart';

@immutable
abstract class EmployeeState {
  final bool isProcessing;
  final String? status;

  const EmployeeState({
    required this.isProcessing,
    this.status,
  });
}

@immutable
class EmployeeStateSaved extends EmployeeState {
  final List<Employee>? currentEmployees;
  final List<Employee>? previousEmployees;
  final Employee? deletedEmployee;

  const EmployeeStateSaved({
    required bool isProcessing,
    this.deletedEmployee,
    String? status,
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
  final Employee? employee;
  DateTime? selectedToDate;

   EmployeeStateIsInAddDetailView({
    this.employee,
     this.selectedToDate,
    required bool isProcessing,
  }) : super(
          isProcessing: isProcessing,
        );
}

extension GetCurrentEmployees on EmployeeState {
  List<Employee>? get currentEmp {
    final cls = this;
    if (cls is EmployeeStateSaved) {
      return cls.currentEmployees;
    } else {
      return null;
    }
  }
}

extension GetPreviousEmployees on EmployeeState {
  List<Employee>? get previousEmp {
    final cls = this;
    if (cls is EmployeeStateSaved) {
      return cls.previousEmployees;
    } else {
      return null;
    }
  }
}

extension GetDeletedEmployee on EmployeeState {
  Employee? get deletedEmployee {
    final cls = this;
    if (cls is EmployeeStateSaved) {
      return cls.deletedEmployee;
    } else {
      return null;
    }
  }
}

extension GetEmployeeToEdit on EmployeeState {
  Employee? get employee {
    final cls = this;
    if (cls is EmployeeStateIsInAddDetailView) {
      return cls.employee;
    } else {
      return null;
    }
  }
}

extension GetDate on EmployeeState {
  DateTime? get toDate {
    final cls = this;
    if (cls is EmployeeStateIsInAddDetailView) {
      return cls.selectedToDate;
    } else {
      return null;
    }
  }
  DateTime? get fromDate {
    final cls = this;
    if (cls is EmployeeStateIsInAddDetailView) {
      return cls.selectedToDate;
    } else {
      return null;
    }
  }

  void setToDate(DateTime newDate) {
    if (this is EmployeeStateIsInAddDetailView) {
      (this as EmployeeStateIsInAddDetailView).selectedToDate = newDate;
    }
  }
}
