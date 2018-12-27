import 'package:eqamah/pages/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF009000),
        ),
      ),
      home: new NavigationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// Color(0xFF009000)
