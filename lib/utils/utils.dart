import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'global.dart';

class Utils {

  static snackBar(String message, {int duration = 3}) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: ColorPalette.titleTextColor,

        action: SnackBarAction(
          label: 'Undo',
          textColor: ColorPalette.primaryColor,
          onPressed: () {

            navigatorKey.currentContext!.read<EmployeeBloc>().add(const EmployeeEventUndoDelete());
          },
        ),
        content: Text(message,
            style: RobotoFonts.regular(
              fontSize: 15.v,
              color: Colors.white,
            )),
        duration: Duration(seconds: duration),

      ),
    );
  }
}
