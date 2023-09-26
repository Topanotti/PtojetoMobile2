import 'package:flutter/material.dart';
import 'package:gameslist2/view/add_developer.dart';
import 'package:gameslist2/view/add_game.dart';
import 'package:gameslist2/view/add_platform.dart';
import 'package:gameslist2/model/game_model.dart';
import 'package:gameslist2/controller/game_controller.dart';

class HomePage extends StatelessWidget {
  final List<Game> games;

  HomePage({required this.games});

  Future<void> updateGameList(BuildContext context) async {
    final updatedGames = await GameController().getGamesFromFirestore();
    //Navigator.of(context).pop(); // Feche a tela de adição de jogo (opcional) Da erro
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(
          games: updatedGames,
        ),
      ),
    );
  }

  void _updateGameStatus(BuildContext context, String gameId, bool isFinished) async {
    await GameController().updateGameFinishedStatus(gameId, isFinished);
    updateGameList(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFinished ? 'Jogo marcado como finalizado' : 'Jogo marcado como não finalizado'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogos'),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GameListItem(game: games[index], updateGameStatus: _updateGameStatus);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddOptions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Plataforma'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPlatformView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Desenvolvedor'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddDeveloperView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Jogo'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddGameView(
                      onGameAdded: () {
                        updateGameList(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class GameListItem extends StatelessWidget {
  final Game game;
  final Function(BuildContext context, String gameId, bool isFinished) updateGameStatus;

  GameListItem({required this.game, required this.updateGameStatus});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(game.logoUrl),
      title: Text(game.name),
      trailing: ElevatedButton(
        onPressed: () {
          updateGameStatus(context, game.id, !game.finished);
        },
        child: Text(game.finished ? 'Finalizado' : 'Finalizar'),
        style: ElevatedButton.styleFrom(
          primary: game.finished ? Colors.red : null,
        ),
      ),
    );
  }
}
