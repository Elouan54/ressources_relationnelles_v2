import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v2/providers/utilisateurs.dart';

class DetailProfil extends StatefulWidget {
  const DetailProfil({super.key, required this.profil, required this.moi});

  final int moi;
  final Utilisateurs profil;

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil de ${widget.profil.pseudo}'),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Nom :${widget.profil.nom}"),
            Text("Prenom :${widget.profil.prenom}"),
            Text("Date de naissance :${widget.profil.dateNaissance}"),
            /* Expanded(
              child: FittedBox(
                child: Image.asset(widget.ressource.),
              ),
            ) */
            if (widget.moi == 1) ...[
              ElevatedButton(
                onPressed: () {
                  //bouton ajouter relation
                },
                child: const Text('Ajouter relation'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
