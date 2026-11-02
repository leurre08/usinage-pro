import 'package:flutter/material.dart';

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
          ListTile(
            leading: const Icon(Icons.category, color: Colors.blueGrey),
            title: const Text('Acier non allié (P1)'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('P1 sélectionné pour $brandId')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.blueGrey),
            title: const Text('Acier inoxydable (M1)'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('M1 sélectionné pour $brandId')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.blueGrey),
            title: const Text('Aluminium (N1)'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('N1 sélectionné pour $brandId')),
              );
            },
          ),
        ],
      ),
    );
  }
}
