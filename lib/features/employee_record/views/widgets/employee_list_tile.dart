import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/enum/enum.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/data/model/employee.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  const EmployeeListTile({
    required this.employee,
    this.onTap,
    this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(employee.name),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        background: Container(
          color: ColorPalette.lightRed,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 17.0),
          child: SvgPicture.asset(
            'assets/images/delete.svg',
            height: 24.v,
            width: 25.v,
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 108.v,
            width: SizeUtils.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.lightGrey,
                  width: 1.h,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    softWrap: true,
                    style: RobotoFonts.medium(
                      fontSize: 16.v,
                      color: ColorPalette.titleTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.v,
                  ),
                  Text(
                    employee.role,
                    softWrap: true,
                    style: RobotoFonts.regular(
                        fontSize: 14.v, color: ColorPalette.lightTextColor),
                  ),
                  SizedBox(
                    height: 6.v,
                  ),
                  Text(
                    'From ${employee.fromDate} - To ${employee.toDate}',
                    softWrap: true,
                    style: RobotoFonts.regular(
                        fontSize: 12.v, color: ColorPalette.lightTextColor),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
