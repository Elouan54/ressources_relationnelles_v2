import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v2/screens/connexion.dart';
import 'package:ressources_relationnelles_v2/screens/relations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'statistiques.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  var user_id;
  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt('user');
    });
    //print("user = " + user_id.toString());
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
  }

  @override
  void initState() {
    getUser();
    getRole();
    Future.delayed(const Duration(seconds: 1), () {
      if (user_id == null) {
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
    //print(user_id);
    if (user_id != null) {
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
              user_id != null ? 'Déconnexion' : 'Connexion',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          if (user_id != null) const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: relations,
            child: const Text(
              'Relations',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          if (role == 3) const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: lienStats,
            child: const Text(
              'Statistiques',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
