import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/employee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => EmployeeBloc()..add(const EmployeeEventInitialize()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BlocConsumer<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if(state is EmployeeStateSaved){
                return const EmployeeListView();
              }else{
                return Container();
              }
            },
            listener: (context, state) {},
          ),
        ));
  }
}
