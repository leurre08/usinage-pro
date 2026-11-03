import 'package:flutter/material.dart';

class CuttingScreen extends StatelessWidget {
  final String operationName;
  final String materialName;

  const CuttingScreen({
    super.key,
    required this.operationName,
    required this.materialName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Conditions de coupe'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // En-tête
          Card(
            elevation: 3,
            color: const Color(0xFF2C5F8A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    operationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    materialName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Paramètres de coupe
          _buildParamCard('Vc', 'Vitesse de coupe', '180', 'm/min', Icons.speed),
          _buildParamCard('fz', 'Avance par dent', '0.08', 'mm/dent', Icons.move_up),
          _buildParamCard('ap', 'Profondeur de passe', '2.0', 'mm', Icons.height),
          _buildParamCard('ae', 'Largeur de coupe', '40', 'mm', Icons.straighten),

          const SizedBox(height: 16),

          // Résultats calculés
          const Text(
            'RÉSULTATS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5F8A),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),

          _buildResultCard('N', 'Vitesse de rotation', '1432', 'tr/min', Icons.rotate_right),
          _buildResultCard('Vf', 'Avance minute', '458', 'mm/min', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildParamCard(String code, String label, String value, String unit, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF5B9BD5),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(label, style: const TextStyle(fontSize: 14)),
        subtitle: Text(code, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text(
          '$value $unit',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C5F8A),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String code, String label, String value, String unit, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF70AD47),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(label, style: const TextStyle(fontSize: 14)),
        subtitle: Text(code, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text(
          '$value $unit',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF70AD47),
          ),
        ),
      ),
    );
  }
}