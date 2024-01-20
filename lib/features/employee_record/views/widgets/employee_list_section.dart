import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/views/widgets/employee_list_tile.dart';
import 'package:flutter/material.dart';


import '../../data/model/employee.dart';

class EmployeeListSection extends StatelessWidget {
  final String title;
  final List<Employee>? employees;

  const EmployeeListSection({
    required this.title,
    this.employees,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(height / 42),
            child: Text(
              title,
              style: RobotoFonts.medium(
                fontSize: height / 42,
                color: ColorPalette.primaryColor,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: employees!
                  .map((employee) => EmployeeListTile(
                        employee: employee,
                        onDismissed: () {
                          // context.read<EmployeeBloc>().add();
                        },
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
