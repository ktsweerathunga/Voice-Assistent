import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/home_screen.dart';
import 'package:voice_assistent/widgets/openAi_service.dart';
import 'package:voice_assistent/config/api_config.dart';

void main() {
  // Initialize OpenAI service with API key
  OpenaiService.initialize(ApiConfig.openaiApiKey);
  
  runApp(const MyApp());
}

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
        ),
      ),
      home: const HomeScreen(),
    );
  }
}