import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../providers/ressources.dart';
import 'detail_ressource.dart';

final dio = Dio();

class Ressource extends StatefulWidget {
  const Ressource({super.key});

  @override
  State<Ressource> createState() => _RessourceState();
}

class _RessourceState extends State<Ressource> {
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

      if (data["validation_moderation"] == true) {
        lesRessources.add(ressource);
      }
    });

    setState(() {
      ressources = lesRessources;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ressources.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailRessource(ressource: ressources[index]),
                )),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ressources[index].titre,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.star_border),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      ressources[index].description,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
