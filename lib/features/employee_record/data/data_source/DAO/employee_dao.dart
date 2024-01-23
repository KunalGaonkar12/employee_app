import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:floor/floor.dart';


@dao
abstract class EmployeeDao{

  @insert
  Future<void> insertEmployee(Employee employee);

  @update
  Future<void> updateEmployee(Employee employee);
  
  @delete
  Future<void> deleteEmployee(Employee employee);
  
  @Query('SELECT * FROM employee_data')
  Future<List<Employee>> getEmployees();
}