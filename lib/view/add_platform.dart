import 'package:flutter/material.dart';
import 'package:gameslist2/controller/platform_controller.dart';
import 'package:gameslist2/view/plataform_list.dart';

class AddPlatformView extends StatelessWidget {
  final PlatformController platformController = PlatformController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _logoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Plataforma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome da Plataforma'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _logoUrlController,
              decoration: InputDecoration(labelText: 'URL do Logo'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final logoUrl = _logoUrlController.text;

                if (name.isNotEmpty && logoUrl.isNotEmpty) {
                  // Chame a função do controlador para adicionar a plataforma
                  platformController.addPlatform(name, logoUrl);

                  // Limpe os campos após adicionar a plataforma
                  _nameController.clear();
                  _logoUrlController.clear();

                  // Exiba um snackbar para informar ao usuário que a plataforma foi adicionada com sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Plataforma adicionada com sucesso!'),
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
              child: Text('Adicionar Plataforma'),

            ),

            ElevatedButton(
              onPressed: () {
                // Navegue para a tela PlatformListView
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlatformListView(),
                  ),
                );
              },
              child: Text('Ver Plataformas'),
            ),
          ],
        ),
      ),
    );
  }
}

