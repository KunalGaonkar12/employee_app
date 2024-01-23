import 'package:employee_app/confic/font/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../confic/colorpalette.dart';
import '../../../../utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIconPath;
  final String? suffixIconPath;
  final double? width;
  final double? height;
  final bool? onlyRead;
  final GestureTapCallback? onTap;

  const CustomTextField({
    required this.controller,
    this.onTap,
    this.onlyRead,
    this.height,
    this.width,
    required this.hintText,
    this.suffixIconPath,
    required this.prefixIconPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.v,
      width: width ?? SizeUtils.width,
      child: TextFormField(
        controller: controller,
        readOnly: onlyRead ?? false,
        onTap: onTap,
        cursorColor: ColorPalette.primaryColor,
        style: RobotoFonts.regular(
          fontSize: 16.v,
          color: ColorPalette.darkBlack,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.v,
          ),
          hintStyle: RobotoFonts.regular(
            fontSize: 16.v,
            color: ColorPalette.lightTextColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              width: 1,
              color: ColorPalette.tineWhite,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.h)),
            borderSide: const BorderSide(
              width: 1,
              color: ColorPalette.tineWhite,
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(
              8.v,
            ),
            child: SvgPicture.asset(
              prefixIconPath,
              height: 24.v,
              width: 24.v,
            ),
          ),
          border: InputBorder.none,
          suffixIcon: suffixIconPath != null
              ? GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.v,
                      horizontal: 8.v,
                    ),
                    child: SvgPicture.asset(
                      suffixIconPath!,
                      height: 20.v,
                      width: 20.v,
                    ),
                  ))
              : null,
        ),
      ),
    );
  }
}
