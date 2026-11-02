import 'package:flutter/material.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2/4 - Marque'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.build, color: Colors.blueGrey),
            title: const Text('Jongen', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Spécialiste fraisage'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Jongen sélectionné')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.build, color: Colors.blueGrey),
            title: const Text('Iscar', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Tous procédés'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iscar sélectionné')),
              );
            },
          ),
        ],
      ),
    );
  }
}
