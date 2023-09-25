import 'platform_model.dart';
import 'developer_model.dart';

class Game {
  final String? id;
  final String name;
  final String logoUrl;
  final int totalHours;
  final double price;
  final Developer developer; // Referência para a desenvolvedora
  final Platform platform; // Referência para a plataforma
  final bool finished;

  Game({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.totalHours,
    required this.price,
    required this.developer,
    required this.platform,
    required this.finished,
  });


}
