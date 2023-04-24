import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class Data {
  final int id;
  final String data;

  Data({required this.data, required this.id});
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  late String valueMail = "";
  late String valueMdp = "";

  bool connected = false;
  bool error = false;

  void valider(mail, mdp) async {
    try {
      final response = await dio
          // ignore: prefer_interpolation_to_compose_strings
          .get('http://localhost:5083/api/Utilisateurs/' + mail + ', ' + mdp);
      if (response.statusCode == 200) {
        StoreLogin(response.data);
      } else {
        setState(() {
          error = true;
        });
        //print('status code erreur');
      }
    } on Exception catch (_) {
      setState(() {
        error = true;
      });
    }
  }

  StoreLogin(data) async {
    //print(data['id_user']);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user', data['id_user']);
    setState(() {
      connected = true;
    });
    final responseModo =
        await dio.get('http://localhost:5083/api/Utilisateurs/modo');
    if (responseModo.statusCode == 200) {
      storeRole(data['id_user'], responseModo.data);
    }
  }

  storeRole(id, dataModo) async {
    //print(dataModo);
    for (var modo in dataModo) {
      if (modo['id_user'] == id) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('role', 2);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('role', 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158),
      ),
      body: connected
          ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(child: Text("Connecté")),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre adresse email';
                        } else {
                          valueMail = value;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'Mot de passe'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        } else {
                          valueMdp = value;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            valider(valueMail, valueMdp);
                          }
                        });
                      },
                      child: const Text('Connexion'),
                    ),
                    const SizedBox(height: 32.0),
                    if (error == true) const Text("Erreur de connexion.")
                  ],
                ),
              ),
            ),
    );
  }
}
