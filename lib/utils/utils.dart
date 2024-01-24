import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:employee_app/utils/colorpalette.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'font/text_style_helper.dart';
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
            navigatorKey.currentContext!
                .read<EmployeeBloc>()
                .add(const EmployeeEventUndoDelete());
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

  static flushBarErrorMessage(String message, {int duration = 3}) {
    showFlushbar(
      context: navigatorKey.currentContext!,
      flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          message: message,
          duration: Duration(seconds: duration),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
          // backgroundColor: Colors.black,
          backgroundColor: Colors.red.withOpacity(0.9),
          messageColor: Colors.white,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: SvgPicture.asset(
            'assets/images/exclamation (1).svg',
            width: 28.v,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ))
        ..show(navigatorKey.currentContext!),
    );
  }
}
