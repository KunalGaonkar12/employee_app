import 'package:employee_app/confic/enum/enum.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:floor/floor.dart';

@immutable
@Entity(tableName: 'employee_data', primaryKeys: ['id'])
class Employee {
  final int? id;
  final EmployeeRole role;
  final String name;
  final String fromDate;
  final String? toDate;

  const Employee({
    this.id,
    required this.role,
    required this.name,
    required this.fromDate,
    this.toDate,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.id == id &&
        other.role == role &&
        other.name == name &&
        other.fromDate == fromDate &&
        other.toDate == toDate;
  }

  @override
  int get hashCode => Object.hash(
        id,
        role,
        name,
        fromDate,
        toDate,
      );

  @override
  String toString() => {
        'id': id,
        'name': name,
        'role': role,
        'fromDate': fromDate,
        'toDate': toDate,
      }.toString();
}
