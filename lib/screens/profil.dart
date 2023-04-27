import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v2/screens/connexion.dart';
import 'package:ressources_relationnelles_v2/screens/relations.dart';
import 'package:ressources_relationnelles_v2/screens/statistiques.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/utilisateurs.dart';
import 'detail_profil.dart';

final dio = Dio();

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  // ignore: prefer_typing_uninitialized_variables
  var userId;
  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user')!;
    });
    //print("user = " + userId.toString());
  }

  int? role;
  getRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role');
      //print("role = " + role.toString());
    });
  }

  removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    getUser();
    getRole();
  }

  @override
  void initState() {
    getUser();
    getRole();
    Future.delayed(const Duration(seconds: 1), () {
      if (userId == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Connexion()),
        ).then((_) => stateUpdate());
      }
    });

    super.initState();
  }

  void stateUpdate() {
    getUser();
    getRole();
    //print("refresh done");
  }

  verifConnexion() {
    //print(userId);
    if (userId != null) {
      removeUser();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Connexion(),
          ));
    }
  }

  lienStats() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Statistiques(),
        ));
  }

  relations() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Relations(),
        ));
  }

  profil(id) async {
    final response =
        await dio.get('http://localhost:5083/api/Utilisateurs/$id');
    //print(response.data);
    final data = response.data;
    final user = Utilisateurs(
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
      dateAccordConfidentialite: data["dateAccordConfidentialite"].toString(),
      numeroTelephone: data["numeroTelephone"].toString(),
      validationRgpd: (data["validationRgpd"] == 0 ? false : true),
      accordConfidentialite:
          (data["accordConfidentialite"] == 0 ? false : true),
    );
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailProfil(
          profil: user,
          moi: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Bienvenue sur votre page de profil',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: verifConnexion,
            child: Text(
              userId != null ? 'Déconnexion' : 'Connexion',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          if (userId != null) ...[
            ElevatedButton(
              onPressed: relations,
              child: const Text(
                'Relations',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            ElevatedButton(
              onPressed: () => profil(userId),
              child: const Text(
                'Profil',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
          if (role == 2) ...[
            ElevatedButton(
              onPressed: lienStats,
              child: const Text(
                'Statistiques',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
