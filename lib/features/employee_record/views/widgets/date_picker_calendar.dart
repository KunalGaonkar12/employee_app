import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../../utils/font/text_style_helper.dart';
import 'package:employee_app/features/employee_record/bloc/employee_bloc.dart';
import 'package:employee_app/features/employee_record/bloc/employee_state.dart';
import 'package:employee_app/features/employee_record/views/widgets/custom_elevated_button.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colorpalette.dart';
import '../../../../utils/datetime_helper.dart';
import '../../bloc/employee_event.dart';

class DatePickerCalendar extends StatelessWidget {
  final List<String> options;
  final String? selectedDate;

  const DatePickerCalendar({
    this.selectedDate,
    required this.options,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeBloc>().add(EmployeeEventOpenCalendar(
        selectedDate: selectedDate!, length: options.length));
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.h),
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            return Container(
              width: 396.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h)),
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
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 16.h,
                          children: List.generate(options.length, (index) {
                            final option = options[index];
                            return CustomElevatedButton(
                              width: 174.h,
                              height: 36.v,
                              text: option,
                              backgroundColor: (state.selectedOption == option)
                                  ? ColorPalette.primaryColor
                                  : null,
                              radious: 4.h,
                              style: RobotoFonts.regular(
                                  fontSize: 14.v,
                                  color: state.selectedOption == option
                                      ? Colors.white
                                      : ColorPalette.primaryColor),
                              onPressed: () {
                                context
                                    .read<EmployeeBloc>()
                                    .add(EmployeeEventSelectOption(option));
                              },
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
            );
          },
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
            const Spacer(),
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
            // selectableDayPredicate: (DateTime day) =>
            //     day.isAfter(DateTime.now().subtract(Duration(days: 1))),
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
          value: [context.read<EmployeeBloc>().state.selectedDate],
          onValueChanged: (dates) {
            context.read<EmployeeBloc>().state.setSelectedDate(dates.first!);
            context.read<EmployeeBloc>().add(EmployeeEventSelectDate());
          },
        ));
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
          DateTimeHelper.formatDateTime(
              context.read<EmployeeBloc>().state.selectedDate),
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
      onPressed: () {
        final date = context.read<EmployeeBloc>().state.selectedDate;

        if (options.length > 2) {
          context.read<EmployeeBloc>().fromDateController.text =
              DateTimeHelper.formatDateTime(date);
        } else {
          context.read<EmployeeBloc>().toDateController.text =
            date!=null?  DateTimeHelper.formatDateTime(date):'';
        }

        Navigator.of(context).pop();
      },
      backgroundColor: ColorPalette.primaryColor,
    );
  }
}
