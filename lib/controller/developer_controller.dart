import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameslist2/model/developer_model.dart';

class DeveloperController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDeveloper(String name, String logoUrl) async {
    try {
      await _firestore.collection('developers').add({
        'name': name,
        'logoUrl': logoUrl,
      });
      print('Desenvolvedora adicionada com sucesso!');
    } catch (e) {
      print('Erro ao adicionar a desenvolvedora: $e');
    }
  }
}
