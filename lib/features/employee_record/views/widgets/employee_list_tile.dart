import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/enum/enum.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;
  final VoidCallback? onDismissed;

  const EmployeeListTile({
    required this.employee,
    this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    if (kDebugMode) {
      print('Screen Height :$height');
      print('Screen Width :$width');
    }
    return Dismissible(
      key: Key(employee.name),
      onDismissed: (direction) {
        if (onDismissed != null) {
          onDismissed;
        }
      },
      direction: DismissDirection.horizontal,
      background: Container(
        color: ColorPalette.lightRed,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(height / 42),
          child: Column(
            children: [
              Text(
                employee.name,
                softWrap: true,
                style: RobotoFonts.medium(
                    fontSize: height / 42, color: ColorPalette.titleTextColor),
              ),
              SizedBox(
                height: height / 113,
              ),
              Text(
                employee.role.roleName,
                softWrap: true,
                style: RobotoFonts.regular(
                    fontSize: height / 48, color: ColorPalette.lightTextColor),
              ),
              SizedBox(
                height: height / 113,
              ),
              Text(
                employee.name,
                softWrap: true,
                style: RobotoFonts.regular(
                    fontSize: height / 48, color: ColorPalette.lightTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
