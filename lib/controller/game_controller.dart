import 'package:gameslist2/model/game_model.dart';

class GameController {
  final List<Game> games = [];

  void addGame(Game game) {
    games.add(game);
  }
}
