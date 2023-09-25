import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameslist2/model/game_model.dart';


class GameController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference gamesCollection = FirebaseFirestore.instance.collection('games');

  Future<void> addGameToFirestore(Game game) async {
    try {
      await gamesCollection.add({
        'name': game.name,
        'logoUrl': game.logoUrl,
        'totalHours': game.totalHours,
        'price': game.price,
        'developerId': game.developer,
        'platformId': game.platform,
        'finished': game.finished,
      });
      print('Jogo adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar o jogo: $e');
    }
  }

  // Implemente métodos para recuperar a lista de jogos e outras operações relacionadas a jogos aqui.
}
