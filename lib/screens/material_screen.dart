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
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.blue, child: Text('P', style: TextStyle(color: Colors.white))),
            title: const Text('P - Aciers'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OperationScreen(brandId: 'test', materialId: 'p1', materialName: 'Acier')));
            },
          ),
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.amber, child: Text('M', style: TextStyle(color: Colors.white))),
            title: const Text('M - Inoxydables'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OperationScreen(brandId: 'test', materialId: 'm1', materialName: 'Inox')));
            },
          ),
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.red, child: Text('K', style: TextStyle(color: Colors.white))),
            title: const Text('K - Fontes'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OperationScreen(brandId: 'test', materialId: 'k1', materialName: 'Fonte')));
            },
          ),
        ],
      ),
    );
  }
}
