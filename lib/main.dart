import 'package:employee_app/injection_container.dart';
import 'package:flutter/material.dart';

import 'features/employee_record/views/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}



