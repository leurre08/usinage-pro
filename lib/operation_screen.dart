import 'package:flutter/material.dart';

class OperationScreen extends StatelessWidget {
  final String brandId;
  final String materialId;
  final String materialName;

  const OperationScreen({
    super.key,
    required this.brandId,
    required this.materialId,
    required this.materialName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4/4 - Opération'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSection('Tournage', ['Chariotage', 'Dressage', 'Saignée', 'Filetage']),
          _buildSection('Fraisage', ['Surfaçage', 'Rainurage', 'Pochage']),
          _buildSection('Perçage', ['Perçage', 'Alésage', 'Lamage']),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> operations) {
    return ExpansionTile(
      leading: const Icon(Icons.settings, color: Colors.blueGrey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: operations.map((op) {
        return ListTile(
          title: Text('  • $op'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$op - $materialName')),
            );
          },
        );
      }).toList(),
    );
  }
}
