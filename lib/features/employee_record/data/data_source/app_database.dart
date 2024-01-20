import 'dart:async';

import 'package:employee_app/confic/enum/enum.dart';
import 'package:employee_app/features/employee_record/data/data_source/DAO/article_dao.dart';
import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'app_database.g.dart';


@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase{

  EmployeeDao get employeeDao;

}