import 'package:flutter/material.dart';

class OperationScreen extends StatelessWidget {
  const OperationScreen({super.key});

  final Map<String, List<String>> operations = const {
    'Tournage': ['Chariotage', 'Dressage', 'Profil', 'Saignée', 'Filetage'],
    'Fraisage': ['Surfaçage', 'Rainurage', 'Pochage', 'Copiage', 'Épaulement'],
    'Perçage': ['Perçage centré', 'Perçage profond', 'Alésage', 'Lamage'],
    'Taraudage': ['Aveugle', 'Débouchant', 'Filet'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4/4 - Opération'),
        centerTitle: true,
      ),
      body: ListView(
        children: operations.entries.map((entry) {
          return ExpansionTile(
            leading: const Icon(Icons.settings, color: Colors.blueGrey),
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: entry.value.map((op) {
              return ListTile(
                title: Text('  • $op'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('${entry.key} - $op'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _row('Vc', '180 m/min'),
                          _row('fz / f', '0.15 mm/dent'),
                          _row('ap', '2.0 mm'),
                          _row('ae', '0.7 × D'),
                          _row('Réfrigérant', 'Oui, arrosage copieux'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}