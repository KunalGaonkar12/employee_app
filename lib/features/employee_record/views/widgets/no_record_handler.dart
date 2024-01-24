import 'package:employee_app/utils/colorpalette.dart';
import '../../../../utils/font/text_style_helper.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NoRecordHandler extends StatelessWidget {
  const NoRecordHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/img_group_5363.svg',
            height: 218.v,
            width: 261.h,
          ),
          SizedBox(
            height: 4.5.v,
          ),
          Text(
            'No employee records found',
            style: RobotoFonts.medium(
              fontSize: 18.v,
              color: ColorPalette.darkBlack,
            ),
          )
        ],
      ),
    );
  }
}
