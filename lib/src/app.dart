import 'package:flutter/material.dart';
import 'package:tarutas/src/views/pages/homePage/home_page.dart';

class TARutas extends StatelessWidget {
  const TARutas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TA Rutas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
