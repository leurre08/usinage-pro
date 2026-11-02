import 'package:flutter/material.dart';
import 'operation_screen.dart';

class MaterialScreen extends StatelessWidget {
  final String brandId;
  const MaterialScreen({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3/4 - Matière')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildGroup(context, 'P', 'Aciers', const Color(0xFF5B9BD5), [
            {'id': 'p01', 'name': 'P01 - Finition, aciers coulés'},
            {'id': 'p10', 'name': 'P10 - Aciers non alliés'},
            {'id': 'p20', 'name': 'P20 - Aciers faiblement alliés'},
            {'id': 'p30', 'name': 'P30 - Aciers faiblement alliés'},
            {'id': 'p40', 'name': 'P40 - Fonte malléable'},
            {'id': 'p50', 'name': 'P50 - Ébauche, aciers alliés'},
          ]),
          _buildGroup(context, 'M', 'Inoxydables', const Color(0xFFEDC948), [
            {'id': 'm10', 'name': 'M10 - Aciers faiblement alliés'},
            {'id': 'm20', 'name': 'M20 - Aciers fortement alliés'},
            {'id': 'm30', 'name': 'M30 - Aciers inoxydables'},
            {'id': 'm40', 'name': 'M40 - Alliages Ni, Co, Ti'},
          ]),
          _buildGroup(context, 'K', 'Fontes', const Color(0xFFE06666), [
            {'id': 'k01', 'name': 'K01 - Finition, fontes'},
            {'id': 'k10', 'name': 'K10 - Fontes, alliages Al'},
            {'id': 'k20', 'name': 'K20 - Métaux légers'},
            {'id': 'k30', 'name': 'K30 - Bois, plastiques'},
          ]),
          _buildGroup(context, 'N', 'Non-ferreux', const Color(0xFF70AD47), [
            {'id': 'n1', 'name': 'N1 - Aluminium, cuivre, laiton'},
          ]),
          _buildGroup(context, 'S', 'Superalliages', const Color(0xFFED7D31), [
            {'id': 's1', 'name': 'S1 - Inconel, alliages Ni'},
          ]),
          _buildGroup(context, 'H', 'Trempés', const Color(0xFF7F7F7F), [
            {'id': 'h1', 'name': 'H1 - Aciers >45 HRC'},
          ]),
        ],
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String code, String name, Color color, List<Map<String, String>> items) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(code, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          title: Text('$code - $name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          children: items.map((item) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(item['name']!, style: const TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF2C5F8A)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperationScreen(
                      brandId: brandId,
                      materialId: item['id']!,
                      materialName: item['name']!,
                    ),
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
