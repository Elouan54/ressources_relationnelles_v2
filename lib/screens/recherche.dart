import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../providers/utilisateurs.dart';

final dio = Dio();

class Recherche extends StatefulWidget {
  const Recherche({Key? key});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final _pseudoController = TextEditingController();
  bool premiere = true;
  bool trouve = false;
  List<Utilisateurs> users = [];

  @override
  Widget build(BuildContext context) {
    rechercheProfil(pseudo) async {
      premiere = false;
      List<Utilisateurs> lesUsers = [];
      final response = await dio.get('http://localhost:5083/api/Utilisateurs');
      response.data.forEach((data) {
        final Utilisateurs utilisateur = Utilisateurs(
          idUser: data["idUser"].toString(),
          pseudo: data["pseudo"].toString(),
          mdp: data["mdp"].toString(),
          email: data["email"].toString(),
          dateNaissance: data["dateNaissance"].toString(),
          nom: data["nom"].toString(),
          nomJeuneFille: data["nomJeuneFille"].toString(),
          prenom: data["prenom"].toString(),
          derniereDateConnexion: data["derniereDateConnexion"].toString(),
          dateValidationRgpd: data["dateValidationRgpd"].toString(),
          dateAccordConfidentialite:
              data["dateAccordConfidentialite"].toString(),
          numeroTelephone: data["numeroTelephone"].toString(),
          validationRgpd: (data["validationRgpd"] == 0 ? false : true),
          accordConfidentialite:
              (data["accordConfidentialite"] == 0 ? false : true),
        );

        if (pseudo == data["pseudo"]) {
          lesUsers.add(utilisateur);
        }
      });

      setState(() {
        if (lesUsers.isNotEmpty) {
          users = lesUsers;
          trouve = true;
        } else {
          trouve = false;
        }
      });
    }

    return Column(
      children: [
        const Text(
          'Recherche par pseudo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _pseudoController,
                decoration: const InputDecoration(
                  hintText: 'Rechercher...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                rechercheProfil(_pseudoController.text);
              },
              child: const Text('Rechercher'),
            ),
          ],
        ),
        if (trouve == true) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    users[0].pseudo,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ] else ...[
          if (premiere == false) ...[
            const Text("Aucun utilisateur avec ce pseudo."),
          ],
        ],
      ],
    );
  }
}
