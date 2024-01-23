import 'package:employee_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/employee_record/views/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    // statusBarColor: Colors.blue,
  ));
  await initializeDependencies();
  runApp(const MyApp());
}
