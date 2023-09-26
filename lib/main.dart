import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameslist2/view/home_page.dart';
import 'controller/game_controller.dart';
import 'model/game_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<Game>>(
        future: GameController().getGamesFromFirestore(), // Obtenha a lista de jogos do Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Mostrar um indicador de carregamento enquanto os dados estão sendo buscados
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            final games = snapshot.data ?? []; // Obtenha a lista de jogos do snapshot
            return HomePage(games: games); // Passe a lista de jogos para a HomePage
          }
        }, // Defina a HomePage como a tela inicial
    ),
  );
  }
}