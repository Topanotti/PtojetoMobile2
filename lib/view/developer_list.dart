import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeveloperListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Desenvolvedoras'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('developers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final developers = snapshot.data?.docs ?? [];
            if (developers.isEmpty) {
              return Center(
                child: Text('Nenhuma desenvolvedora encontrada.'),
              );
            }
            
            return ListView.builder(
              itemCount: developers.length,
              itemBuilder: (context, index) {
                final developer = developers[index];
                final name = developer['name'] ?? '';
                final logoUrl = developer['logoUrl'] ?? '';

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
              child: Text('Erro ao carregar as desenvolvedoras: ${snapshot.error}'),
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
