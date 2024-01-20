import 'package:employee_app/features/employee_record/data/data_source/app_database.dart';
import 'package:employee_app/features/employee_record/data/model/employee.dart';

class EmployeeRepository {

  final AppDatabase appDatabase;

  const EmployeeRepository({required this.appDatabase});

   Future<List<Employee>> getEmployeeRecords() async{
    return appDatabase.employeeDao.getEmployees();
  }


  Future<void> saveEmployee(Employee employee) async{
    return appDatabase.employeeDao.insertEmployee(employee);
  }

  Future<void> updateEmployee(Employee employee) async{
    return appDatabase.employeeDao.updateEmployee(employee);
  }

  Future<void> deleteEmployee(Employee employee) async{
    return appDatabase.employeeDao.deleteEmployee(employee);
  }


}