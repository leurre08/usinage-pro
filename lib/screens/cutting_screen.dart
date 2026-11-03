import 'package:flutter/material.dart';

class CuttingScreen extends StatefulWidget {
  final String operationName;
  final String materialId;
  final String materialName;

  const CuttingScreen({
    super.key,
    required this.operationName,
    required this.materialId,
    required this.materialName,
  });

  @override
  State<CuttingScreen> createState() => _CuttingScreenState();
}

class _CuttingScreenState extends State<CuttingScreen> {
  late TextEditingController _vcController;
  late TextEditingController _feedController;
  late TextEditingController _apController;
  late TextEditingController _aeController;
  late TextEditingController _dController;
  late TextEditingController _zController;

  double _n = 0;
  double _vf = 0;

  // Détermine si c'est du fraisage (pour adapter les calculs et libellés)
  bool get isMilling => widget.operationName.contains('Fraisage');
  bool get isDrilling => widget.operationName.contains('Perçage');
  bool get isTurning => widget.operationName.contains('Tournage');

  String get feedLabel => isMilling ? 'fz (Avance par dent)' : 'f (Avance par tour)';
  String get feedUnit => isMilling ? 'mm/dent' : 'mm/tr';

  @override
  void initState() {
    super.initState();
    _loadDefaultValues();
  }

  void _loadDefaultValues() {
    // On extrait la première lettre du materialId (p, m, k, n, s, h)
    String group = widget.materialId.substring(0, 1).toLowerCase();
    Map<String, dynamic> defaults = _getDefaults(widget.operationName, group);

    _vcController = TextEditingController(text: defaults['vc'].toString());
    _feedController = TextEditingController(text: defaults['feed'].toString());
    _apController = TextEditingController(text: defaults['ap'].toString());
    _aeController = TextEditingController(text: defaults['ae'].toString());
    _dController = TextEditingController(text: defaults['d'].toString());
    _zController = TextEditingController(text: defaults['z'].toString());

    _calculate();
  }

  Map<String, dynamic> _getDefaults(String operation, String group) {
    // Valeurs moyennes issues de ton fichier Excel (AideAuxCalculs)
    if (operation.contains('Tournage')) {
      if (group == 'p') return {'vc': 275, 'feed': 0.30, 'ap': 2.0, 'ae': 0.0, 'd': 40, 'z': 1};
      if (group == 'm') return {'vc': 150, 'feed': 0.20, 'ap': 1.5, 'ae': 0.0, 'd': 40, 'z': 1};
      if (group == 'k') return {'vc': 180, 'feed': 0.35, 'ap': 2.0, 'ae': 0.0, 'd': 40, 'z': 1};
      if (group == 'n') return {'vc': 400, 'feed': 0.40, 'ap': 3.0, 'ae': 0.0, 'd': 40, 'z': 1};
      if (group == 's') return {'vc': 60, 'feed': 0.15, 'ap': 1.0, 'ae': 0.0, 'd': 40, 'z': 1};
      if (group == 'h') return {'vc': 80, 'feed': 0.10, 'ap': 0.5, 'ae': 0.0, 'd': 40, 'z': 1};
    } else if (operation.contains('Fraisage')) {
      if (group == 'p') return {'vc': 180, 'feed': 0.10, 'ap': 2.0, 'ae': 20.0, 'd': 40, 'z': 4};
      if (group == 'm') return {'vc': 120, 'feed': 0.08, 'ap': 1.5, 'ae': 15.0, 'd': 40, 'z': 4};
      if (group == 'k') return {'vc': 150, 'feed': 0.12, 'ap': 2.0, 'ae': 20.0, 'd': 40, 'z': 4};
      if (group == 'n') return {'vc': 350, 'feed': 0.15, 'ap': 3.0, 'ae': 30.0, 'd': 40, 'z': 4};
      if (group == 's') return {'vc': 50, 'feed': 0.06, 'ap': 1.0, 'ae': 10.0, 'd': 40, 'z': 4};
      if (group == 'h') return {'vc': 70, 'feed': 0.05, 'ap': 0.5, 'ae': 5.0, 'd': 40, 'z': 4};
    } else if (operation.contains('Perçage')) {
      if (group == 'p') return {'vc': 30, 'feed': 0.20, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
      if (group == 'm') return {'vc': 20, 'feed': 0.15, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
      if (group == 'k') return {'vc': 40, 'feed': 0.25, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
      if (group == 'n') return {'vc': 80, 'feed': 0.30, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
      if (group == 's') return {'vc': 15, 'feed': 0.10, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
      if (group == 'h') return {'vc': 20, 'feed': 0.08, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1};
    }
    
    // Valeurs par défaut de secours
    return {'vc': 100, 'feed': 0.1, 'ap': 1.0, 'ae': 10.0, 'd': 40, 'z': isMilling ? 4 : 1};
  }

  void _calculate() {
    final vc = double.tryParse(_vcController.text) ?? 0;
    final feed = double.tryParse(_feedController.text) ?? 0;
    final d = double.tryParse(_dController.text) ?? 0;
    final z = double.tryParse(_zController.text) ?? 1;

    if (d > 0) {
      setState(() {
        // Formule : N = (Vc * 1000) / (π * D)
        _n = (vc * 1000) / (3.14159 * d);
        // Formule : Vf = N * feed * z (z=1 pour tournage/perçage)
        _vf = _n * feed * z;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(title: const Text('Conditions de coupe')),
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
                  Text(widget.operationName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.materialName, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Paramètres de coupe
          _buildInputCard('Vc', 'Vitesse de coupe', _vcController, 'm/min', Icons.speed),
          _buildInputCard('f', feedLabel, _feedController, feedUnit, Icons.move_up),
          if (!isDrilling) _buildInputCard('ap', 'Profondeur de passe', _apController, 'mm', Icons.height),
          if (isMilling) _buildInputCard('ae', 'Largeur de coupe', _aeController, 'mm', Icons.straighten),

          const SizedBox(height: 16),
          const Text('OUTIL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2C5F8A), letterSpacing: 1)),
          const SizedBox(height: 8),

          _buildInputCard('D', 'Diamètre outil', _dController, 'mm', Icons.circle),
          if (isMilling) _buildInputCard('z', 'Nombre de dents', _zController, 'dents', Icons.grid_view),

          const SizedBox(height: 16),
          const Text('RÉSULTATS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2C5F8A), letterSpacing: 1)),
          const SizedBox(height: 8),

          _buildResultCard('N', 'Vitesse de rotation', _n.toStringAsFixed(0), 'tr/min', Icons.rotate_right),
          _buildResultCard('Vf', 'Avance minute', _vf.toStringAsFixed(0), 'mm/min', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildInputCard(String code, String label, TextEditingController controller, String unit, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: const Color(0xFF5B9BD5), child: Icon(icon, color: Colors.white)),
        title: Text(label, style: const TextStyle(fontSize: 14)),
        subtitle: Text(code, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: SizedBox(
          width: 120,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C5F8A)),
            decoration: InputDecoration(
              suffixText: unit,
              suffixStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) => _calculate(),
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
        leading: CircleAvatar(backgroundColor: const Color(0xFF70AD47), child: Icon(icon, color: Colors.white)),
        title: Text(label, style: const TextStyle(fontSize: 14)),
        subtitle: Text(code, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text('$value $unit', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF70AD47))),
      ),
    );
  }
}