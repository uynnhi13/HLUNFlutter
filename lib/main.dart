import 'package:flutter/material.dart';
import 'package:hlmobile/mainpage.dart';
import 'package:hlmobile/page/auth/login.dart';
import 'package:hlmobile/page/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
        ),
      );
  }
}
