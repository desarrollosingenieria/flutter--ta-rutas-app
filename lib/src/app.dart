import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tarutas/src/constants/constants.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/pages/homePage/home_page.dart';

class TARutas extends StatelessWidget {
  const TARutas({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: TAColors.brandblue),
          home: const HomePage(),
        );
      },
    );
  }
}
