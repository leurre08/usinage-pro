import 'package:flutter/material.dart';
import 'operation_screen.dart';

class MaterialScreen extends StatelessWidget {
  final String brandId;
  const MaterialScreen({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3/4 - Matière'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildGroup(context, 'P', 'Aciers', Colors.blue, [
            {'id': 'p01', 'name': 'P01 - Finition, aciers coulés'},
            {'id': 'p10', 'name': 'P10 - Aciers non alliés'},
            {'id': 'p20', 'name': 'P20 - Aciers faiblement alliés'},
            {'id': 'p30', 'name': 'P30 - Aciers faiblement alliés'},
            {'id': 'p40', 'name': 'P40 - Fonte malléable'},
            {'id': 'p50', 'name': 'P50 - Ébauche, aciers alliés'},
          ]),
          _buildGroup(context, 'M', 'Inoxydables', Colors.amber, [
            {'id': 'm10', 'name': 'M10 - Aciers faiblement alliés'},
            {'id': 'm20', 'name': 'M20 - Aciers fortement alliés'},
            {'id': 'm30', 'name': 'M30 - Aciers inoxydables'},
            {'id': 'm40', 'name': 'M40 - Alliages Ni, Co, Ti'},
          ]),
          _buildGroup(context, 'K', 'Fontes', Colors.red, [
            {'id': 'k01', 'name': 'K01 - Finition, fontes'},
            {'id': 'k10', 'name': 'K10 - Fontes, alliages Al'},
            {'id': 'k20', 'name': 'K20 - Métaux légers'},
            {'id': 'k30', 'name': 'K30 - Bois, plastiques'},
          ]),
          _buildGroup(context, 'N', 'Non-ferreux', Colors.green, [
            {'id': 'n1', 'name': 'N1 - Aluminium, cuivre, laiton'},
          ]),
          _buildGroup(context, 'S', 'Superalliages', Colors.orange, [
            {'id': 's1', 'name': 'S1 - Inconel, alliages Ni'},
          ]),
          _buildGroup(context, 'H', 'Trempés', Colors.grey, [
            {'id': 'h1', 'name': 'H1 - Aciers >45 HRC'},
          ]),
        ],
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String code, String name, Color color, List<Map<String, String>> items) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(code, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      title: Text('$code - $name', style: const TextStyle(fontWeight: FontWeight.bold)),
      children: items.map((item) {
        return ListTile(
          title: Text(item['name']!),
          trailing: const Icon(Icons.chevron_right),
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
    );
  }
}
