import 'package:flutter/material.dart';
import 'package:gameslist2/view/add_developer.dart';
import 'package:gameslist2/view/add_game.dart';
import 'package:gameslist2/view/add_platform.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogos Finalizados'),
      ),
      body: Center(
        child: GameList(), // Aqui exibiremos a lista de jogos
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        showAddOptions(context);
      },
      child: Icon(Icons.add),
      ),
    );
  }
}

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aqui você pode exibir a lista de jogos
    // Substitua o exemplo de lista por seus dados reais do Firebase
    final List<String> games = ['Jogo 1', 'Jogo 2', 'Jogo 3'];

    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(games[index]),
          // Você pode adicionar mais informações do jogo aqui
        );
      },
    );
  }
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
              // Navegar para a tela de adição de plataforma
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
