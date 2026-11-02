import 'package:flutter/material.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

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
                const SnackBar(content: Text('P1 sélectionné')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.blueGrey),
            title: const Text('Acier inoxydable (M1)'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('M1 sélectionné')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.blueGrey),
            title: const Text('Aluminium (N1)'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('N1 sélectionné')),
              );
            },
          ),
        ],
      ),
    );
  }
}
