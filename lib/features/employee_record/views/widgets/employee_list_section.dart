import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/views/widgets/employee_list_tile.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/employee.dart';

class EmployeeListSection extends StatelessWidget {
  final String title;
  final List<Employee>? employees;
  final double? height;

  const EmployeeListSection({
    required this.title,
    this.height,
    this.employees,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.v),
          child: Text(
            title,
            style: RobotoFonts.medium(
              fontSize: 16.v,
              color: ColorPalette.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: employees!.isNotEmpty
              ? Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: employees!
                          .map((employee) => EmployeeListTile(
                                employee: employee,
                                onDismissed: (direction) async {
                                  context.read<EmployeeBloc>().add(
                                        EmployeeEventDelete(employee: employee),
                                      );
                                },
                                onTap: () {
                                  context.read<EmployeeBloc>().add(
                                      EmployeeEventGoToAdd(employee: employee));
                                },
                              ))
                          .toList(),
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                ),
        )
      ],
    );
  }
}
