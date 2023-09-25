import 'package:cloud_firestore/cloud_firestore.dart';

class Platform {
  final String id;
  final String name;
  final String logoUrl;

  Platform({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  // Método para criar uma instância de Platform a partir de um documento Firestore
  factory Platform.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Platform(
      id: doc.id,
      name: data['name'] ?? '',
      logoUrl: data['logoUrl'] ?? '', 
    );
  }   
}
