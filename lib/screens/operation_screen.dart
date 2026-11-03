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
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('4/4 - Opération'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildGroup(context, 'Tournage', Icons.rotate_right, const Color(0xFF2C5F8A), [
            'Chariotage', 'Dressage', 'Saignée', 'Gorge', 'Filetage', 'Profil'
          ]),
          _buildGroup(context, 'Fraisage', Icons.grid_view, const Color(0xFF2C5F8A), [
            'Surfaçage', 'Rainurage', 'Pochage', 'Épaulement', 'Copiage'
          ]),
          _buildGroup(context, 'Perçage', Icons.center_focus_strong, const Color(0xFF2C5F8A), [
            'Perçage', 'Lamage', 'Chambrage', 'Alésage'
          ]),
          _buildGroup(context, 'Taraudage', Icons.text_fields, const Color(0xFF2C5F8A), [
            'Taraudage', 'Lamage de fond', 'Fraisage de filets'
          ]),
        ],
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String title, IconData icon, Color color, List<String> operations) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          children: operations.map((op) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(Icons.circle, size: 8, color: Color(0xFF2C5F8A)),
              title: Text(op, style: const TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF2C5F8A)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$op sur $materialName'),
                    backgroundColor: const Color(0xFF2C5F8A),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
