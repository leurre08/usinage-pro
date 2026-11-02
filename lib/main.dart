import 'package:flutter/material.dart';
import 'screens/brand_screen.dart';

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
        primaryColor: const Color(0xFF2C5F8A),
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C5F8A),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C5F8A),
          background: const Color(0xFFF0F4F8),
        ),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.precision_manufacturing, size: 80, color: Color(0xFF2C5F8A)),
            const SizedBox(height: 20),
            const Text(
              'Bienvenue !',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2C5F8A)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Conditions de coupe',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BrandScreen()),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Commencer', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C5F8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

