import 'package:employee_app/confic/enum/enum.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_event.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/widgets/bottom_sheet.dart';
import 'package:employee_app/features/employee_record/views/widgets/custom_elevated_button.dart';
import 'package:employee_app/features/employee_record/views/widgets/custom_text_widget.dart';
import 'package:employee_app/features/employee_record/views/widgets/date_picker_calendar.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/colorpalette.dart';
import '../../../utils/font/text_style_helper.dart';
import '../data/model/employee.dart';

class AddDetailsView extends StatelessWidget {
  AddDetailsView({Key? key}) : super(key: key);

  final fromDateOption = [
    'Today',
    'Next Monday',
    'Next Tuesday',
    'After 1 Week'
  ];
  final toDateOption = ['No date', 'Today'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingBottomBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBody(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24.v,
        horizontal: 16.h,
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: context.read<EmployeeBloc>().nameController,
            hintText: 'Employee name',
            prefixIconPath:
                'assets/images/person_FILL0_wght300_GRAD0_opsz24 (2) 1.svg',
          ),
          SizedBox(
            height: 23.v,
          ),
          CustomTextField(
            onlyRead: true,
            onTap: () async {
              final role = await openBottomSheet(context, EmployeeRole.values);
              if (kDebugMode) {
                print(role);
              }
              context.read<EmployeeBloc>().roleController.text = role ?? '';
            },
            controller: context.read<EmployeeBloc>().roleController,
            hintText: 'Select role',
            prefixIconPath: 'assets/images/office_bag.svg',
            suffixIconPath: 'assets/images/arrow.svg',
          ),
          SizedBox(
            height: 23.v,
          ),
          _buildFrame(context)
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    final employee = context.watch<EmployeeBloc>().state.employee;
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.v, horizontal: 16.h),
        child: Text(
          employee == null ? 'Add Employee Details' : 'Edit Employee Details',
          style: RobotoFonts.medium(
            fontSize: 18.v,
            color: Colors.white,
          ),
        ),
      ),
      actions: employee != null
          ? [
              IconButton(
                onPressed: () {
                  context.read<EmployeeBloc>().add(
                        EmployeeEventDelete(employee: employee),
                      );
                },
                icon: SvgPicture.asset(
                  'assets/images/delete.svg',
                  height: 24.v,
                  width: 25.v,
                ),
              )
            ]
          : [],
      backgroundColor: ColorPalette.primaryColor,
      toolbarHeight: 60.v,
      titleSpacing: 0,
    );
  }

  Widget _buildFloatingBottomBar(
    BuildContext context,
  ) {
    return Container(
      height: 64.v,
      width: SizeUtils.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorPalette.lightGrey,
            width: 2.h,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.v,
          horizontal: 16.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // mainAxisSize: MainAxisSize.min,
          children: [
            _buildCancel(
              context,
            ),
            SizedBox(
              width: 16.h,
            ),
            _buildSave(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFrame(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextField(
          onlyRead: true,
          width: 172.h,
          controller: context.read<EmployeeBloc>().fromDateController,
          hintText: 'Today',
          prefixIconPath: 'assets/images/event.svg',
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DatePickerCalendar(
                    options: fromDateOption,
                    selectedDate:
                        context.read<EmployeeBloc>().fromDateController.text,
                  );
                });
          },
        ),
        SvgPicture.asset(
          'assets/images/arrow_right.svg',
          width: 20.v,
          height: 20.v,
        ),
        CustomTextField(
          onlyRead: true,
          width: 172.h,
          controller: context.read<EmployeeBloc>().toDateController,
          hintText: 'No date',
          prefixIconPath: 'assets/images/event.svg',
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DatePickerCalendar(
                    options: toDateOption,
                    selectedDate:
                        context.read<EmployeeBloc>().toDateController.text,
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      width: 73.h,
      height: 40.v,
      text: 'Cancel',
      textColor: ColorPalette.primaryColor,
      onPressed: () {
        context.read<EmployeeBloc>().add(const EmployeeEventGoToEmployeeList());
      },
    );
  }

  Widget _buildSave(
    BuildContext context,
  ) {
    return CustomElevatedButton(
      width: 73.h,
      height: 40.v,
      text: 'Save',
      onPressed: () {
        context.read<EmployeeBloc>().add(
              EmployeeEventSave(
                employee: Employee(
                    name: context.read<EmployeeBloc>().nameController.text,
                    role: context.read<EmployeeBloc>().roleController.text,
                    fromDate:
                        context.read<EmployeeBloc>().fromDateController.text,
                    toDate: context.read<EmployeeBloc>().toDateController.text),
              ),
            );
      },
      backgroundColor: ColorPalette.primaryColor,
    );
  }
}
