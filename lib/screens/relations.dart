import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../providers/relations.dart';

class Relations extends StatefulWidget {
  const Relations({super.key});

  @override
  State<Relations> createState() => _RelationsState();
}

class _RelationsState extends State<Relations> {
  List<Relation> relations = [];
  final dio = Dio();

  @override
  void initState() {
    fetchRessources();
    super.initState();
  }

  void fetchRessources() async {
    List<Relation> lesRelations = [];

    final response =
        await dio.get('http://localhost:5083/api/Relation_Utilisateurs');
    print(response.data);
    response.data.forEach((data) {
      final Relation relation = Relation(
          idRelationUtilisateurs: data["idRelationUtilisateurs"] ?? 0,
          utilisateur: data["utilisateur"] ?? 0,
          utilisateurVoulu: data["utilisateurVoulu"] ?? 0,
          typeRelation: data["typeRelation"].toString(),
          relationConfirmee: (data["relationConfirmee"] == 0 ? false : true));

      if (data["validation_moderation"] == true) {
        lesRelations.add(relation);
      }
    });

    setState(() {
      relations = lesRelations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relations"),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158),
      ),
      body: ListView.builder(
        itemCount: relations.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    relations[index].utilisateurVoulu.toString(),
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    relations[index].typeRelation,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
