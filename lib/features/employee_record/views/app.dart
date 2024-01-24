import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/add_detail_view.dart';
import 'package:employee_app/features/employee_record/views/employee_list_view.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:employee_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/global.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
          create: (_) => EmployeeBloc()..add(const EmployeeEventInitialize()),
          child: MaterialApp(
            title: 'Employee App',
            scaffoldMessengerKey: scaffoldMessengerKey,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: BlocConsumer<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeStateSaved) {
                  return const EmployeeListView();
                } else if (state is EmployeeStateIsInAddDetailView) {
                  return AddDetailsView();
                } else {
                  return Container();
                }
              },
              listener: (context, state) {
                if (state is EmployeeStateSaved) {
                  if (state.status != null) {
                    Utils.snackBar(state.status!);
                  }
                }
                if (state is EmployeeStateIsInAddDetailView) {
                  if (state.errorMessage != '') {
                    Utils.flushBarErrorMessage(state.errorMessage ?? '');
                  }
                }
              },
            ),
          ));
    });
  }
}
