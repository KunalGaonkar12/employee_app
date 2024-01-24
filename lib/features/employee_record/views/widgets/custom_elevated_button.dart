import 'package:employee_app/utils/colorpalette.dart';
import '../../../../utils/font/text_style_helper.dart';
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
  final TextStyle? style;

  const CustomElevatedButton({
    required this.width,
    this.style,
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
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                radious ?? 6.h),
          ),
          backgroundColor: backgroundColor ?? ColorPalette.lightBlue,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12.h),
        ),
        child: Text(
          text,
          style: style ??
              RobotoFonts.medium(
                  fontSize: 14.v, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
