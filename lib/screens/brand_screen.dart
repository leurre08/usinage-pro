import 'package:flutter/material.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  final List<Map<String, String>> brands = const [
    {'id': 'jongen', 'name': 'Jongen', 'spec': 'Spécialiste fraisage'},
    {'id': 'iscar', 'name': 'Iscar', 'spec': 'Tous procédés'},
    {'id': 'add', 'name': '+ Ajouter un fabricant', 'spec': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2/4 - Marque de l\'outil'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return ListTile(
            leading: const Icon(Icons.build, color: Colors.blueGrey),
            title: Text(brand['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(brand['spec']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Marque ${brand['name']} sélectionnée. Écran matière à créer.')),
              );
            },
          );
        },
      ),
    );
  }
}