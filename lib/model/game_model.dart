import 'package:cloud_firestore/cloud_firestore.dart';

import 'platform_model.dart';
import 'developer_model.dart';

class Game {
  final String id;
  final String name;
  final String logoUrl;
  final int totalHours;
  final double price;
  final String developerId; // Chave estrangeira para o desenvolvedor
  final String platformId;  // Chave estrangeira para a plataforma
  final bool finished;

  Game({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.totalHours,
    required this.price,
    required this.developerId,
    required this.platformId,
    required this.finished,
  });

// Método para criar uma instância de Game a partir de um documento Firestore
  factory Game.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Game(
      id: doc.id,
      name: data['name'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      totalHours: data['totalHours'] ?? 0,
      price: data['price'] ?? 0.0,
      developerId: data['developerId'] ?? '',
      platformId: data['platformId'] ?? '',
      finished: data['finished'] ?? false,
    );
  }

}

