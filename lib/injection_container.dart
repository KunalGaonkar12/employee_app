
import 'package:get_it/get_it.dart';
import 'features/employee_record/data/data_source/app_database.dart';
import 'features/employee_record/data/repository/employee_repository.dart';

final sl =GetIt.instance;

Future<void> initializeDependencies() async{

  //Database
  final database= await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //Repository
  sl.registerSingleton<EmployeeRepository>(EmployeeRepository(appDatabase: sl()));



}