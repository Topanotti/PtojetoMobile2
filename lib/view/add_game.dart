import 'package:flutter/material.dart';
import 'package:gameslist2/controller/game_controller.dart';
import 'package:gameslist2/model/game_model.dart';
import 'package:gameslist2/model/platform_model.dart';
import 'package:gameslist2/model/developer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGameView extends StatefulWidget {
  
  final Function onGameAdded;
  AddGameView({required this.onGameAdded});

  @override
  _AddGameViewState createState() => _AddGameViewState();
}

class _AddGameViewState extends State<AddGameView> {
  final GameController gameController = GameController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _logoUrlController = TextEditingController();
  final TextEditingController _totalHoursController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Variáveis para armazenar os IDs selecionados
  String? selectedDeveloperId;
  String? selectedPlatformId;

  // Listas de itens para os dropdowns
  List<DropdownMenuItem<String>> developerItems = [];
  List<DropdownMenuItem<String>> platformItems = [];

  @override
  void initState() {
    super.initState();
    // Preencha as listas de itens dos dropdowns com dados existentes
    _loadDeveloperItems();
    _loadPlatformItems();
  }

  // Função para carregar os desenvolvedores do Firebase Firestore
  Future<void> _loadDeveloperItems() async {
    print("Loading developers...");
    final developersQuery = FirebaseFirestore.instance.collection('developers');
    final developersSnapshot = await developersQuery.get();

    developerItems.clear(); // Limpe a lista antes de adicionar itens

    for (var doc in developersSnapshot.docs) {
      final developer = Developer.fromSnapshot(doc);
      developerItems.add(
       DropdownMenuItem(
          value: developer.id,
          child: Text(developer.name),
        ),
      );
    }
    setState(() {});
  }

  // Função para carregar as plataformas do Firebase Firestore
  Future<void> _loadPlatformItems() async {
    print("Loading platforms...");
    final platformsQuery = FirebaseFirestore.instance.collection('platforms');
    final platformsSnapshot = await platformsQuery.get();
    
    platformItems.clear(); // Limpe a lista antes de adicionar itens

    for (var doc in platformsSnapshot.docs) {
      final platform = Platform.fromSnapshot(doc);
      platformItems.add(
        DropdownMenuItem(
          value: platform.id,
          child: Text(platform.name),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Jogo'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _logoUrlController,
              decoration: InputDecoration(labelText: 'URL do Logo'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _totalHoursController,
              decoration: InputDecoration(labelText: 'Total de Horas'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Preço'),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedDeveloperId,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDeveloperId = newValue;
                });
              },
              items: developerItems,
              hint: Text('Selecione a Desenvolvedora'),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedPlatformId,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPlatformId = newValue;
                });
              },
              items: platformItems,
              hint: Text('Selecione a Plataforma'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final logoUrl = _logoUrlController.text;
                final totalHours = int.tryParse(_totalHoursController.text) ?? 0;
                final price = double.tryParse(_priceController.text) ?? 0.0;
                final developerId = selectedDeveloperId;
                final platformId = selectedPlatformId;

                if (name.isNotEmpty && logoUrl.isNotEmpty && developerId != null && platformId != null) {
                  final newGame = Game(
                    id: '', // Deixe vazio para que o Firebase gere automaticamenteID será atribuído automaticamente pelo Firebase
                    name: name,
                    logoUrl: logoUrl,
                    totalHours: totalHours,
                    price: price,
                    developerId: selectedDeveloperId!,
                    platformId: selectedPlatformId!,
                    finished: false, // Por padrão, um novo jogo não está finalizado
                  );

                  // Chame a função do controlador para adicionar o jogo
                  gameController.addGameToFirestore(newGame);

                  // Chame o callback para notificar a HomePage
                  widget.onGameAdded(); // Isso notificará a HomePage

                  // Limpe os campos após adicionar o jogo
                  _nameController.clear();
                  _logoUrlController.clear();
                  _totalHoursController.clear();
                  _priceController.clear();

                  // Exiba um snackbar para informar ao usuário que o jogo foi adicionado com sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Jogo adicionado com sucesso!'),
                    ),
                  );
                } else {
                  // Exiba um snackbar para informar ao usuário que os campos são obrigatórios
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, preencha todos os campos obrigatórios.'),
                    ),
                  );
                }
              },
              child: Text('Adicionar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
