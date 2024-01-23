import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/widgets/custom_elevated_button.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../confic/colorpalette.dart';

class DatePickerCalendar extends StatelessWidget {
  const DatePickerCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: 396.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.h)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 24.v, bottom: 16.v, left: 16.h, right: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.v,
                  crossAxisSpacing: 16.h,
                  children: List.generate(4, (index) {
                    return CustomElevatedButton(
                      width: 174.h,
                      height: 36.v,
                      text: 'daadd',
                      textColor: ColorPalette.primaryColor,
                      radious: 4.h,
                    );
                  }),
                ),
                _buildCalendar(context),
              ],
            ),
          ),
          __buildBottomFrame(context),
        ],
      ),
    ));
  }

  Widget __buildBottomFrame(BuildContext context) {
    return Container(
      height: 72.v,
      width: SizeUtils.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorPalette.lightGrey,
            width: 1.h,
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
          children: [
            _buildDate(context),
            Spacer(),
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

  Widget _buildCalendar(BuildContext context) {
    return SizedBox(
      height: 276.v,
      width: 368.h,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          firstDayOfWeek: 0,
          weekdayLabelTextStyle: RobotoFonts.regular(
            fontSize: 15.v,
            color: ColorPalette.titleTextColor,
          ),
          controlsTextStyle: RobotoFonts.medium(
              fontSize: 18.v, color: ColorPalette.titleTextColor),
          centerAlignModePicker: true,
          disableModePicker: true,
          nextMonthIcon: SvgPicture.asset(
            'assets/images/arrow_next.svg',
            width: 24.h,
            height: 24.v,
            colorFilter: const ColorFilter.mode(
                ColorPalette.lightTextColor, BlendMode.srcIn),
          ),
          lastMonthIcon: SvgPicture.asset(
            'assets/images/arrow_previous.svg',
            width: 24.h,
            height: 24.v,
            colorFilter: const ColorFilter.mode(
                ColorPalette.lightTextColor, BlendMode.srcIn),
          ),
          selectedDayTextStyle:
              RobotoFonts.regular(fontSize: 15.v, color: Colors.white),
          selectedDayHighlightColor: ColorPalette.primaryColor,
          dayTextStyle: RobotoFonts.regular(
            fontSize: 15.v,
            color: ColorPalette.titleTextColor,
          ),
          weekdayLabels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
          dayBorderRadius: BorderRadius.circular(
            14.h,
          ),
        ),
        value: [DateTime.now()],
        onValueChanged: (dates) {
          context.read<EmployeeBloc>().state.setToDate(dates.first!);
          print(dates);
        },
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      width: 73.h,
      height: 40.v,
      text: 'Cancel',
      textColor: ColorPalette.primaryColor,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildDate(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/event.svg',
          height: 23.v,
          width: 20.h,
        ),
        SizedBox(
          width: 12.h,
        ),
        Text(
          context.watch<EmployeeBloc>().state.toDate.toString(),
          style: RobotoFonts.regular(
              fontSize: 16.v, color: ColorPalette.titleTextColor),
        )
      ],
    );
  }

  Widget _buildSave(
    BuildContext context,
  ) {
    return CustomElevatedButton(
      width: 73.h,
      height: 40.v,
      text: 'Save',
      onPressed: () {},
      backgroundColor: ColorPalette.primaryColor,
    );
  }
}
