import 'package:flutter/material.dart';
import '../services/cutting_data_service.dart';

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

  final Map<String, List<Map<String, String>>> operations = const {
    'Tournage': [
      {'id': 'chariotage', 'name': 'Chariotage'},
      {'id': 'dressage', 'name': 'Dressage'},
      {'id': 'chariotage_profile', 'name': 'Profil'},
      {'id': 'saignee', 'name': 'Saignée'},
      {'id': 'filetage', 'name': 'Filetage'},
    ],
    'Fraisage': [
      {'id': 'surfacage', 'name': 'Surfaçage'},
      {'id': 'rainurage', 'name': 'Rainurage'},
      {'id': 'pochage', 'name': 'Pochage'},
      {'id': 'copiage', 'name': 'Copiage'},
      {'id': 'epaulement', 'name': 'Épaulement'},
    ],
    'Perçage': [
      {'id': 'perçage_centre', 'name': 'Perçage centré'},
      {'id': 'perçage_profond', 'name': 'Perçage profond'},
      {'id': 'alésage', 'name': 'Alésage'},
      {'id': 'lamage', 'name': 'Lamage'},
    ],
    'Taraudage': [
      {'id': 'taraudage_aveugle', 'name': 'Aveugle'},
      {'id': 'taraudage_debouchant', 'name': 'Débouchant'},
      {'id': 'taraudage_filet', 'name': 'Filet'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4/4 - Opération'), centerTitle: true),
      body: ListView(
        children: operations.entries.map((entry) {
          return ExpansionTile(
            leading: const Icon(Icons.settings, color: Colors.blueGrey),
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: entry.value.map((op) {
              return ListTile(
                title: Text('  • ${op['name']}'),
                onTap: () => _showResult(context, entry.key, op['name']!, op['id']!),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  void _showResult(BuildContext context, String proc, String opName, String opId) {
    final data = CuttingDataService.instance.getCondition(
      brandId: brandId,
      operationId: opId,
      materialId: materialId,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$proc - $opName'),
        content: data == null
            ? const Text('Aucune donnée disponible pour cette combinaison.\nUtilisez le mode admin pour l\'ajouter.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: data.entries.map((e) => _row(e.key, e.value.toString())).toList(),
              ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
