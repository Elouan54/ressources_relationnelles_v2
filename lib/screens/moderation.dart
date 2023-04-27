import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../providers/ressources.dart';
import 'package:intl/intl.dart';

class Moderation extends StatefulWidget {
  const Moderation({super.key});

  @override
  State<Moderation> createState() => _ModerationState();
}

class _ModerationState extends State<Moderation> {
  List<Ressources> ressources = [];
  final dio = Dio();

  @override
  void initState() {
    fetchRessources();
    super.initState();
  }

  void fetchRessources() async {
    List<Ressources> lesRessources = [];
    final response = await dio.get('http://localhost:5083/api/Ressources');

    //print(response.statusCode);
    response.data.forEach((data) {
      final Ressources ressource = Ressources(
          id_ressource: data["id_ressource"].toString(),
          titre: data["titre"].toString(),
          // langue_nom: data["langue_nom"].toString(),
          date_moderation: data["date_moderation"].toString(),
          validation_moderation:
              (data["validation_moderation"] == 0 ? false : true),
          description: data["description"].toString(),
          age_minimum: data["age_minimum"] ?? 0,
          compteur_vue: data["compteur_vue"] ?? 0);

      if (data["validation_moderation"] == false) {
        lesRessources.add(ressource);
      }
    });

    setState(() {
      ressources = lesRessources;
    });
  }

  void valider(id) async {
    final responseSelect =
        // ignore: prefer_interpolation_to_compose_strings
        await dio.get('http://localhost:5083/api/Ressources/' + id);
    if (responseSelect.statusCode == 200) {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
      final dateFormat = formatter.format(now);

      // Mise à jour des données de la ressource avec les nouvelles valeurs
      final ressource = Ressources(
        id_ressource: responseSelect.data["id_ressource"].toString(),
        titre: responseSelect.data["titre"].toString(),
        // langue_nom: responseSelect.data["langue_nom"].toString(),
        date_moderation: dateFormat,
        validation_moderation: true,
        description: responseSelect.data["description"].toString(),
        age_minimum: responseSelect.data["age_minimum"] ?? 0,
        compteur_vue: responseSelect.data["compteur_vue"] ?? 0,
      );
      //print(responseSelect.data);

      // Envoi d'une requête PUT pour mettre à jour la ressource sur le serveur
      final responseUpdate = await dio.put(
        'http://localhost:5083/api/Ressources/${ressource.id_ressource}',
        data: ressource.toJson(),
      );
      //print(responseUpdate.statusCode);
      if (responseUpdate.statusCode == 204) {
        fetchRessources();
        //print(responseUpdate.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: ressources.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: CheckboxListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ressources[index].titre,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ressources[index].description,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    value: false,
                    onChanged: (bool? newValue) {
                      setState(() {
                        ressources[index].validation_moderation =
                            newValue ?? false;
                      });
                      valider(ressources[index].id_ressource);
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
