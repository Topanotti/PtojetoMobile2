class Game {
  final String id;
  final String name;
  final String logoUrl;
  final int totalHours;
  final double price;
  final String developerId;
  final bool finished;

  Game({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.totalHours,
    required this.price,
    required this.developerId,
    required this.finished,
  });
}
