import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameslist2/model/game_model.dart';

class GameController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Adicione um jogo ao Firestore
  Future<void> addGameToFirestore(Game game) async {
    try {
      await _firestore.collection('games').add({
        'name': game.name,
        'logoUrl': game.logoUrl,
        'totalHours': game.totalHours,
        'price': game.price,
        'developerId': game.developerId, // Use o ID do desenvolvedor
        'platformId': game.platformId,   // Use o ID da plataforma
        'finished': game.finished,
      });
      print('Jogo adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar o jogo: $e');
    }
  }

  // Implemente métodos para recuperar a lista de jogos e outras operações relacionadas a jogos aqui.
  Future<List<Game>> getGamesFromFirestore() async {
    final gamesQuery = _firestore.collection('games');
    final gamesSnapshot = await gamesQuery.get();
    
    return gamesSnapshot.docs.map((doc) => Game.fromSnapshot(doc)).toList();
  }

  Future<void> updateGameFinishedStatus(String gameId, bool isFinished) async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .update({'finished': isFinished});
  }  
}
