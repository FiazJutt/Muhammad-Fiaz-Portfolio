import 'package:flutter/material.dart';
import 'package:portfolio/app/theme/app_theme.dart';
import 'package:portfolio/features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiaz Jutt - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
