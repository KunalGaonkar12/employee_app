import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final TextStyle? buttonTextStyle;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? radious;

  const CustomElevatedButton({
    required this.width,
    this.backgroundColor,
    this.radious,
    this.textColor,
    this.buttonTextStyle,
    required this.height,
    required this.text,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      // width: width,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(radious??6.h),
      //   color: backgroundColor ?? ColorPalette.lightBlue,
      // ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radious??6.h), // Adjust the radius as needed
          ),
          backgroundColor: backgroundColor ?? ColorPalette.lightBlue,
          disabledBackgroundColor: backgroundColor ?? ColorPalette.lightBlue,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12.h),
        ),
        child: Text(
          text,
          style: RobotoFonts.medium(
              fontSize: 14.v, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
