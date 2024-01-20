enum Status { saved, edited, deleted, unknown }

enum EmployeeRole { productDesigner, flutterDeveloper, qaTester, productOwner }

extension GetState on Status {
  String? get message {
    switch (this) {
      case Status.saved:
        return "Employee record saved";
      case Status.deleted:
        return "Employee record deleted";
      case Status.edited:
        return "Employee record Edited";
      default:
        return 'Unknown error occurred try again';
    }
  }
}


extension EmployeeRoleExtension on EmployeeRole {
  String get roleName {
    switch (this) {
      case EmployeeRole.productDesigner:
        return 'Product Designer';
      case EmployeeRole.flutterDeveloper:
        return 'Flutter Developer';
      case EmployeeRole.qaTester:
        return 'QA Tester';
      case EmployeeRole.productOwner:
        return 'Product Owner';
    }
  }
}

