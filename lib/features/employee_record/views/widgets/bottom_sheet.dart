import 'package:employee_app/utils/colorpalette.dart';
import 'package:employee_app/confic/enum/enum.dart';
import 'package:employee_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../../utils/font/text_style_helper.dart';

Future<String?> openBottomSheet(
    BuildContext context, List<EmployeeRole> itemList) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.v),
      ),
    ),
    useSafeArea: true,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(item.roleName);
                },
                child: Container(
                  height: 52.v,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 16.v,
                    ),
                    child: Center(
                      child: Text(
                        item.roleName,
                        style: RobotoFonts.regular(
                            fontSize: 16.v, color: ColorPalette.darkBlack),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 2,
                color: ColorPalette.lightGrey,
              );
            },
            itemCount: itemList.length);
      });
    },
  );
}
