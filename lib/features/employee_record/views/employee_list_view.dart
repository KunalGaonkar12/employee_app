import 'package:employee_app/confic/colorpalette.dart';
import 'package:employee_app/confic/font/font.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    if(kDebugMode){
      print('Screen Height :$height');
      print('Screen Width :$width');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: RobotoFonts.medium(fontSize: 18),
        ),
        backgroundColor: ColorPalette.primaryColor,
      ),
    );
  }
}
