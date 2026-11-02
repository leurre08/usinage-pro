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
          ListTile(title: const Text('Chariotage'), onTap: () {}),
          ListTile(title: const Text('Dressage'), onTap: () {}),
          ListTile(title: const Text('Surfaçage'), onTap: () {}),
          ListTile(title: const Text('Perçage'), onTap: () {}),
        ],
      ),
    );
  }
}
