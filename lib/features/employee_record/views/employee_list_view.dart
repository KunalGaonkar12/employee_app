import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/widgets/employee_list_section.dart';
import 'package:employee_app/features/employee_record/views/widgets/no_record_handler.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/size_utils.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Screen Height :${SizeUtils.height}');
      print('Screen Width :${SizeUtils.width}');
    }

    final currentEmployees =
        context.watch<EmployeeBloc>().state.currentEmp ?? [];
    final previousEmployees =
        context.watch<EmployeeBloc>().state.previousEmp ?? [];

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: ColorPalette.lightGrey,
      // backgroundColor: Colors.black,
      body: (currentEmployees.isNotEmpty || previousEmployees.isNotEmpty)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: EmployeeListSection(
                    title: 'Current employees',
                    employees: currentEmployees,
                  ),
                ),
                Expanded(
                  child: EmployeeListSection(
                    title: 'Previous employees',
                    employees: previousEmployees,
                  ),
                ),
                Container(
                  height: 80.v,
                  color: ColorPalette.lightGrey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12.v,
                      left: 16.h,
                    ),
                    child: Text(
                      'Swipe left to delete',
                      style: RobotoFonts.regular(
                        fontSize: 14.v,
                        color: ColorPalette.lightTextColor,
                      ),
                    ),
                  ),
                )
              ],
            )
          : const NoRecordHandler(),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.all(
          16.v,
        ),
        child: Text(
          'Employee List',
          style: RobotoFonts.medium(
            fontSize: 18.v,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: ColorPalette.primaryColor,
      toolbarHeight: 60.v,
      titleSpacing: 0,
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.v,right: 8.h),
      height: 50.v,
      width: 50.v,
      child: FloatingActionButton(
        onPressed: () {
          context.read<EmployeeBloc>().add(const  EmployeeEventGoToAdd());
        },
        backgroundColor: Colors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: SvgPicture.asset(
          'assets/images/PlusIcon.svg',
          height: 18.v,
          width: 18.v,
        ),
      ),
    );
  }
}
