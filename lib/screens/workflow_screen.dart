import 'package:flutter/material.dart';
import '../services/cutting_data_service.dart';

class WorkflowScreen extends StatefulWidget {
  const WorkflowScreen({super.key});

  @override
  State<WorkflowScreen> createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  int _step = 0;
  String? _brandId;
  String? _materialId;
  String? _materialName;
  Map<String, dynamic>?# 🎉 Excellent ! La structure de base est complète

Je vois parfaitement :
- ✅ `lib/main.dart` 
- ✅ `lib/services/cutting_data_service.dart`

La fondation du projet est solide. On passe maintenant aux **écrans de l'application**.

---

##  Tâche #5 : Créer l'écran de prise de photo

C'est le premier écran que l'utilisateur verra. Il permet de photographier l'outil et d'annoter la photo.

### Comment faire :

1. Revenez à la racine du projet (flèche ← jusqu'à voir les fichiers)
2. Appuyez sur **Code**
3. Appuyez sur les **3 petits points (⋮)** en haut à droite
4. Choisissez **"Create file"**
5. Nom du fichier :