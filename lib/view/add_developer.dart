import 'package:flutter/material.dart';
import 'package:gameslist2/controller/developer_controller.dart';

class AddDeveloperView extends StatelessWidget {
  final DeveloperController developerController = DeveloperController();

  final TextEditingController _developerNameController = TextEditingController();
  final TextEditingController _developerLogoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Desenvolvedora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _developerNameController,
              decoration: InputDecoration(labelText: 'Nome da Desenvolvedora'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _developerLogoUrlController,
              decoration: InputDecoration(labelText: 'URL do Logo'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final name = _developerNameController.text;
                final logoUrl = _developerLogoUrlController.text;

                if (name.isNotEmpty && logoUrl.isNotEmpty) {
                  // Chame a função do controlador para adicionar a desenvolvedora
                  developerController.addDeveloper(name, logoUrl);

                  // Limpe os campos após adicionar a desenvolvedora
                  _developerNameController.clear();
                  _developerLogoUrlController.clear();

                  // Exiba um snackbar para informar ao usuário que a desenvolvedora foi adicionada com sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Desenvolvedora adicionada com sucesso!'),
                    ),
                  );
                } else {
                  // Exiba um snackbar para informar ao usuário que os campos são obrigatórios
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, preencha todos os campos.'),
                    ),
                  );
                }
              },
              child: Text('Adicionar Desenvolvedora'),
            ),
          ],
        ),
      ),
    );
  }
}
