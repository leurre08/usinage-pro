import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CuttingDataService {
  static CuttingDataService? _instance;
  Map<String, dynamic>? _data;

  CuttingDataService._();
  static CuttingDataService get instance => _instance ??= CuttingDataService._();

  Future<void> init() async {
    final jsonStr = await rootBundle.loadString('assets/cutting_conditions.json');
    _data = jsonDecode(jsonStr);
  }

  List<Map<String, dynamic>> get brands {
    final list = _data!['brands'] as List;
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  List<Map<String, dynamic>> get materials {
    final list = _data!['materials'] as List;
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Map<String, List<Map<String, dynamic>>> get operations {
    final raw = _data!['operations'] as Map<String, dynamic>;
    return raw.map((k, v) => MapEntry(
      k,
      (v as List).map((e) => Map<String, dynamic>.from(e)).toList(),
    ));
  }

  Map<String, dynamic>? getCondition({
    required String brandId,
    required String operationId,
    required String materialId,
  }) {
    final key = '${brandId}_${operationId}_${materialId}';
    final conditions = _data!['conditions'] as Map<String, dynamic>;
    return conditions[key] as Map<String, dynamic>?;
  }
}