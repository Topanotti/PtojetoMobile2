import 'package:flutter/material.dart';
import 'package:gameslist2/view/add_developer.dart';
import 'package:gameslist2/view/add_game.dart';
import 'package:gameslist2/view/add_platform.dart';
import 'package:gameslist2/model/game_model.dart';
import 'package:gameslist2/controller/game_controller.dart';

class HomePage extends StatelessWidget {
  final List<Game> games;

  HomePage({required this.games});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogos'),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GameListItem(game: games[index]);
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
                // Navegar para a tela de adição de plataforma
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
                // Navegar para a tela de adição de desenvolvedor
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
                    builder: (context) => AddGameView(),
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

  GameListItem({required this.game});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(game.logoUrl), // Exibe a logo do jogo
      title: Text(game.name), // Exibe o nome do jogo
      trailing: ElevatedButton(
        onPressed: () {
          // Lógica para marcar o jogo como finalizado ou desfazer
          // Você pode implementar a lógica aqui
          // Por exemplo, você pode chamar uma função para atualizar o estado do jogo no Firebase Firestore
        },
        child: Text(game.finished ? 'Desfazer' : 'Finalizado'),
      ),
    );
  }
}