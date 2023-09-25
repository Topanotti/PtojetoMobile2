import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlatformListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Plataformas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('platforms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final platforms = snapshot.data?.docs ?? [];
            if (platforms.isEmpty) {
              return Center(
                child: Text('Nenhuma plataforma encontrada.'),
              );
            }
            
            return ListView.builder(
              itemCount: platforms.length,
              itemBuilder: (context, index) {
                final platform = platforms[index];
                final name = platform['name'] ?? '';
                final logoUrl = platform['logoUrl'] ?? '';

                return ListTile(
                  title: Text(name),
                  leading: Image.network(
                    logoUrl,
                    width: 40, // Defina o tamanho da imagem conforme necessário
                    height: 40,
                  ),
                  trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implemente a lógica de edição aqui
                        // Você pode abrir uma nova tela para edição ou mostrar um diálogo de edição
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Implemente a lógica de exclusão aqui
                        // Pode ser mostrando um diálogo de confirmação antes de excluir
                      },
                    ),
                  ],
                  ),

                  // Você pode adicionar mais informações da plataforma aqui
                );

              

              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar as plataformas: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
