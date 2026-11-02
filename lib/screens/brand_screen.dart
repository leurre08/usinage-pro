import 'package:flutter/material.dart';
import 'material_screen.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaterialScreen(brandId: 'jongen'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.build, color: Colors.blueGrey),
            title: const Text('Iscar', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Tous procédés'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaterialScreen(brandId: 'iscar'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
