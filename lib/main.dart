import 'package:flutter/material.dart';
import 'package:orbit/screens/landing_page/landing_page.dart';

void main() {
  runApp(const OrbitApp());
}

class OrbitApp extends StatelessWidget {
  const OrbitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORBIT',
      theme: ThemeData(
        primaryColor: const Color(0xFF6B46C1),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF6B46C1),
          secondary: Colors.pink[400]!,
          surface: const Color(0xFF0A0E1F),
        ),
        fontFamily: 'Poppins',
      ),
      home: const LandingPage(),
    );
  }
}