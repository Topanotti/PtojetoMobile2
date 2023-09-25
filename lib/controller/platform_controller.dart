import 'package:gameslist2/model/platform_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlatformController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addPlatform(String name, String logoUrl) async {
    try {
      await _firestore.collection('platforms').add({
        'name': name,
        'logoUrl': logoUrl,
      });

      

      print('Plataforma adicionada com sucesso!');
    } catch (e) {
      print('Erro ao adicionar a plataforma: $e');
    }
  }
  
  final List<Platform> platforms = [];


}
