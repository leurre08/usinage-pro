import 'package:flutter/material.dart';
import 'screens/photo_screen.dart';

void main() {
  runApp(const UsinageProApp());
}

class UsinageProApp extends StatelessWidget {
  const UsinageProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usinage Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const PhotoScreen(),
    );
  }
}