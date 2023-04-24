// ignore_for_file: non_constant_identifier_names

import 'package:uuid/uuid.dart';

class Ressources {
  //int id_ressource;
  String? id_ressource = const Uuid().v4();
  String titre;
  // String langue_nom;
  String date_moderation;
  bool validation_moderation;
  String description;
  int age_minimum;
  int compteur_vue;

  Ressources(
      {required this.id_ressource,
      required this.titre,
      // required this.langue_nom,
      required this.date_moderation,
      required this.validation_moderation,
      required this.description,
      required this.age_minimum,
      required this.compteur_vue});

  Map<String, dynamic> toJson() => {
        'id_ressource': id_ressource,
        'titre': titre,
        // 'langue_nom': langue_nom,
        'date_moderation': date_moderation,
        'validation_moderation': validation_moderation,
        'description': description,
        'age_minimum': age_minimum,
        'compteur_vue': compteur_vue,
      };
}
