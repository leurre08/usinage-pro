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
  late TextEditingController _pitchController;
  late TextEditingController _etaController;

  double _n = 0;
  double _vf = 0;
  double _q = 0;
  double _power = 0;

  bool get isMilling => widget.operationName.contains('Fraisage');
  bool get isDrilling => widget.operationName.contains('Perçage');
  bool get isTurning => widget.operationName.contains('Tournage');
  bool get isThreading => widget.operationName.contains('Taraudage');

  // ✅ CORRECTION : libellés adaptés selon l'opération
  String get feedLabel {
    if (isThreading) return 'Pas du filetage';
    if (isMilling) return 'fz (Avance par dent)';
    if (isDrilling) return 'fz (Avance par arête)';
    return 'f (Avance par tour)';
  }

  String get feedUnit {
    if (isThreading) return 'mm';
    if (isMilling || isDrilling) return 'mm/dt';
    return 'mm/tr';
  }

  String get feedCode {
    if (isThreading) return 'Pas';
    if (isMilling || isDrilling) return 'fz';
    return 'f';
  }

  IconData get toolIcon {
    if (isMilling) return Icons.grid_view;
    if (isDrilling) return Icons.center_focus_strong;
    if (isThreading) return Icons.text_fields;
    return Icons.rotate_right;
  }

  double _getKc() {
    String group = widget.materialId.substring(0, 1).toLowerCase();
    Map<String, double> kcValues = {
      'p': 230, 'm': 270, 'k': 170, 'n': 140, 's': 470, 'h': 330,
    };
    return kcValues[group] ?? 230;
  }

  @override
  void initState() {
    super.initState();
    _loadDefaultValues();
  }

  void _loadDefaultValues() {
    String group = widget.materialId.substring(0, 1).toLowerCase();
    Map<String, dynamic> defaults = _getDefaults(widget.operationName, group);

    _vcController = TextEditingController(text: defaults['vc'].toString());
    _feedController = TextEditingController(text: defaults['feed'].toString());
    _apController = TextEditingController(text: defaults['ap'].toString());
    _aeController = TextEditingController(text: defaults['ae'].toString());
    _dController = TextEditingController(text: defaults['d'].toString());
    _zController = TextEditingController(text: defaults['z'].toString());
    _pitchController = TextEditingController(text: defaults['pitch'].toString());
    _etaController = TextEditingController(text: '0.85');

    _calculate();
  }

  Map<String, dynamic> _getDefaults(String operation, String group) {
    if (operation.contains('Tournage')) {
      if (group == 'p') return {'vc': 275, 'feed': 0.30, 'ap': 2.0, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
      if (group == 'm') return {'vc': 150, 'feed': 0.20, 'ap': 1.5, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
      if (group == 'k') return {'vc': 180, 'feed': 0.35, 'ap': 2.0, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
      if (group == 'n') return {'vc': 400, 'feed': 0.40, 'ap': 3.0, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
      if (group == 's') return {'vc': 60, 'feed': 0.15, 'ap': 1.0, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
      if (group == 'h') return {'vc': 80, 'feed': 0.10, 'ap': 0.5, 'ae': 0.0, 'd': 40, 'z': 1, 'pitch': 0.0};
    } else if (operation.contains('Fraisage')) {
      // ✅ Valeurs fz par dent (et non par tour)
      if (group == 'p') return {'vc': 180, 'feed': 0.10, 'ap': 2.0, 'ae': 20.0, 'd': 63, 'z': 6, 'pitch': 0.0};
      if (group == 'm') return {'vc': 120, 'feed': 0.08, 'ap': 1.5, 'ae': 15.0, 'd': 63, 'z': 6, 'pitch': 0.0};
      if (group == 'k') return {'vc': 150, 'feed': 0.12, 'ap': 2.0, 'ae': 20.0, 'd': 63, 'z': 6, 'pitch': 0.0};
      if (group == 'n') return {'vc': 350, 'feed': 0.15, 'ap': 3.0, 'ae': 30.0, 'd': 63, 'z': 6, 'pitch': 0.0};
      if (group == 's') return {'vc': 50, 'feed': 0.06, 'ap': 1.0, 'ae': 10.0, 'd': 63, 'z': 6, 'pitch': 0.0};
      if (group == 'h') return {'vc': 70, 'feed': 0.05, 'ap': 0.5, 'ae': 5.0, 'd': 63, 'z': 6, 'pitch': 0.0};
    } else if (operation.contains('Perçage')) {
      if (group == 'p') return {'vc': 30, 'feed': 0.10, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
      if (group == 'm') return {'vc': 20, 'feed': 0.08, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
      if (group == 'k') return {'vc': 40, 'feed': 0.12, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
      if (group == 'n') return {'vc': 80, 'feed': 0.15, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
      if (group == 's') return {'vc': 15, 'feed': 0.05, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
      if (group == 'h') return {'vc': 20, 'feed': 0.04, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 2, 'pitch': 0.0};
    } else if (operation.contains('Taraudage')) {
      if (group == 'p') return {'vc': 30, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
      if (group == 'm') return {'vc': 20, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
      if (group == 'k') return {'vc': 25, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
      if (group == 'n') return {'vc': 40, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
      if (group == 's') return {'vc': 15, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
      if (group == 'h') return {'vc': 18, 'feed': 1.5, 'ap': 0.0, 'ae': 0.0, 'd': 10, 'z': 1, 'pitch': 1.5};
    }
    return {'vc': 100, 'feed': 0.1, 'ap': 1.0, 'ae': 10.0, 'd': 40, 'z': 1, 'pitch': 1.5};
  }

  void _calculate() {
    final vc = double.tryParse(_vcController.text) ?? 0;
    final feed = double.tryParse(_feedController.text) ?? 0;
    final ap = double.tryParse(_apController.text) ?? 0;
    final ae = double.tryParse(_aeController.text) ?? 0;
    final d = double.tryParse(_dController.text) ?? 0;
    final z = double.tryParse(_zController.text) ?? 1;
    final pitch = double.tryParse(_pitchController.text) ?? 0;
    final eta = double.tryParse(_etaController.text) ?? 0.85;
    final kc = _getKc();

    if (d > 0) {
      setState(() {
        _n = (vc * 1000) / (3.14159 * d);

        // ✅ Formules correctes selon opération
        if (isThreading) {
          _vf = _n * pitch;
        } else if (isMilling || isDrilling) {
          // Fraisage ET Perçage : Vf = N × fz × z
          _vf = _n * feed * z;
        } else {
          // Tournage : Vf = N × f
          _vf = _n * feed;
        }

        // Débit copeaux et Puissance
        if (isMilling && ap > 0 && ae > 0) {
          _q = (ap * ae * _vf) / 1000;
          _power = (kc * _q) / (60000 * eta);
        } else if (isTurning && ap > 0) {
          _q = ap * feed * vc;
          _power = (kc * ap * feed * vc) / (60000 * eta);
        } else if (isDrilling) {
          final fc = kc * (d / 2) * feed;
          _power = (fc * vc) / (6000 * eta);
          _q = (3.14159 * d * d / 4) * _vf / 1000;
        } else {
          _q = 0;
          _power = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(title: const Text('Conditions de coupe')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.04,
              child: Center(
                child: Icon(toolIcon, size: 400, color: const Color(0xFF2C5F8A)),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                elevation: 3,
                color: const Color(0xFF2C5F8A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Icon(toolIcon, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.operationName, 
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(widget.materialName, 
                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              _buildSectionTitle('COUPE'),
              _buildInputRow('Vc', _vcController, 'm/min', Icons.speed),
              _buildInputRow(feedCode, _feedController, feedUnit, Icons.move_up),
              if (!isDrilling && !isThreading) 
                _buildInputRow('ap', _apController, 'mm', Icons.height),
              if (isMilling) 
                _buildInputRow('ae', _aeController, 'mm', Icons.straighten),

              const SizedBox(height: 12),

              _buildSectionTitle('OUTIL'),
              _buildInputRow('D', _dController, 'mm', Icons.circle),
              
              // ✅ CORRECTION : z affiché pour Fraisage ET Perçage
              if (isMilling) 
                _buildInputRow('z', 'Nombre de dents', _zController, 'dents', Icons.grid_view),
              if (isDrilling) 
                _buildInputRow('z', "Nombre d'arêtes", _zController, 'arêtes', Icons.grid_view),
              
              if (isThreading)
                _buildInputRow('Pas', _pitchController, 'mm', Icons.text_fields),
              _buildInputRow('η', _etaController, '', Icons.battery_charging_full),

              const SizedBox(height: 12),

              _buildSectionTitle('RÉSULTATS'),
              _buildResultRow('N', _n.toStringAsFixed(0), 'tr/min', Icons.rotate_right, Colors.blue),
              _buildResultRow('Vf', _vf.toStringAsFixed(0), 'mm/min', Icons.trending_up, Colors.blue),
              if (_q > 0)
                _buildResultRow('Q', _q.toStringAsFixed(1), 'cm³/min', Icons.water_drop, Colors.orange),
              if (_power > 0)
                _buildResultRow('P', _power.toStringAsFixed(2), 'kW', Icons.flash_on, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(title, 
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, 
          color: Color(0xFF2C5F8A), letterSpacing: 1.5)),
    );
  }

  Widget _buildInputRow(String label, TextEditingController controller, String unit, IconData icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF5B9BD5), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              width: 110,
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C5F8A)),
                decoration: InputDecoration(
                  suffixText: unit,
                  suffixStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onChanged: (value) => _calculate(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String code, String value, String unit, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 3),
      color: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(code, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
                  Text(unit, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
            Text(value, 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}