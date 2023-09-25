import 'package:flutter/material.dart';
import 'package:gameslist2/model/developer_model.dart';

class AddDeveloperScreen extends StatefulWidget {
  @override
  _AddDeveloperScreenState createState() => _AddDeveloperScreenState();
}

class _AddDeveloperScreenState extends State<AddDeveloperScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Desenvolvedora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome da Desenvolvedora'),
            ),
            TextField(
              controller: logoUrlController,
              decoration: InputDecoration(labelText: 'Link para o Logo'),
            ),
            ElevatedButton(
              onPressed: () {
                // Crie uma nova desenvolvedora com os dados fornecidos pelo usuário.
                final newDeveloper = DeveloperModel(
                  id: 'ID_DA_NOVA_DESENVOLVEDORA', // Gere um ID único aqui (por exemplo, usando UUID).
                  name: nameController.text,
                  logoUrl: logoUrlController.text,
                );

                // Adicione a lógica para salvar a nova desenvolvedora no Firebase aqui.
              },
              child: Text('Adicionar Desenvolvedora'),
            ),
          ],
        ),
      ),
    );
  }
}