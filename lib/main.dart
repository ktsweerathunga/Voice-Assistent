import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: ColorPalette.whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorPalette.whiteColor,
        )
        ),
      home: HomeScreen()
    );
  }
}