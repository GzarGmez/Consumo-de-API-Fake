import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/recovery_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recovery Project',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/recovery': (context) => RecoveryScreen(),
      },
    );
  }
}
