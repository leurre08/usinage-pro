import 'package:flutter/material.dart';

class CuttingScreen extends StatefulWidget {
  final String operationName;
  final String materialName;

  const CuttingScreen({
    super.key,
    required this.operationName,
    required this.materialName,
  });

  @override
  State<CuttingScreen> createState() => _CuttingScreenState();
}

class _CuttingScreenState extends State<CuttingScreen> {
  final TextEditingController _vcController = TextEditingController(text: '180');
  final TextEditingController _fzController = TextEditingController(text: '0.08');
  final TextEditingController _apController = TextEditingController(text: '2.0');
  final TextEditingController _aeController = TextEditingController(text: '40');
  final TextEditingController _dController = TextEditingController(text: '40');
  final TextEditingController _zController = TextEditingController(text: '4');

  double _n = 0;
  double _vf = 0;

  void _calculate() {
    final vc = double.tryParse(_vcController.text) ?? 0;
    final fz = double.tryParse(_fzController.text) ?? 0;
    final ap = double.tryParse(_apController.text) ?? 0;
    final ae = double.tryParse(_aeController.text) ?? 0;
    final d = double.tryParse(_dController.text) ?? 0;
    final z = double.tryParse(_zController.text) ?? 0;

    if (d > 0 && z > 0) {
      setState(() {
        _n = (vc * 1000) / (3.14159 * d);
        _vf = _n * fz * z;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _calculate();
  }

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
                    widget.operationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.materialName,
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
          _buildInputCard('Vc', 'Vitesse de coupe', _vcController, 'm/min', Icons.speed, () => _calculate()),
          _buildInputCard('fz', 'Avance par dent', _fzController, 'mm/dent', Icons.move_up, () => _calculate()),
          _buildInputCard('ap', 'Profondeur de passe', _apController, 'mm', Icons.height, () => _calculate()),
          _buildInputCard('ae', 'Largeur de coupe', _aeController, 'mm', Icons.straighten, () => _calculate()),

          const SizedBox(height: 16),
          const Text(
            'OUTIL',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5F8A),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),

          _buildInputCard('D', 'Diamètre outil', _dController, 'mm', Icons.circle, () => _calculate()),
          _buildInputCard('z', 'Nombre de dents', _zController, 'dents', Icons.grid_view, () => _calculate()),

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

          _buildResultCard('N', 'Vitesse de rotation', _n.toStringAsFixed(0), 'tr/min', Icons.rotate_right),
          _buildResultCard('Vf', 'Avance minute', _vf.toStringAsFixed(0), 'mm/min', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildInputCard(String code, String label, TextEditingController controller, String unit, IconData icon, VoidCallback onChanged) {
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
        trailing: SizedBox(
          width: 120,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C5F8A),
            ),
            decoration: InputDecoration(
              suffixText: unit,
              suffixStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) => onChanged(),
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