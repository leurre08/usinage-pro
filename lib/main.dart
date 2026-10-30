import 'package:flutter/material.dart';

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
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usinage Pro'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Application en cours de développement',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
