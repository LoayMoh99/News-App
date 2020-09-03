import 'package:flutter/material.dart';
import 'package:news_app_api/models/country.dart';
import 'package:news_app_api/views/start_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Country(),
      child: MaterialApp(
        title: 'Flutter News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.teal,
          disabledColor: Colors.grey.withOpacity(0.2),
        ),
        home: StartScreen(),
      ),
    );
  }
}
