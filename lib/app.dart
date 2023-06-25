import 'package:airbnb_host_passport/core/app_theme.dart';
import 'package:airbnb_host_passport/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbnb Host Passport',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
