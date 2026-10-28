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
        scaffoldBackgroundColor: Colors.grey[100],
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.precision_manufacturing,
                size: 100,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 24),
              const Text(
                'Conditions de coupe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Photographiez votre outil et obtenez\nles paramètres de coupe en un tap',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO : navigation vers l'écran photo
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Écran photo à créer (tâche suivante)'),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Commencer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}