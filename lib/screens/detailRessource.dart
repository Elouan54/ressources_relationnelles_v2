import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v2/providers/ressources.dart';

class DetailRessource extends StatefulWidget {
  const DetailRessource({super.key, required this.ressource});

  final Ressources ressource;

  @override
  State<DetailRessource> createState() => _DetailRessourceState();
}

class _DetailRessourceState extends State<DetailRessource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ressource.titre),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Titre :${widget.ressource.titre}"),
            Text("Description :${widget.ressource.description}"),
            /* Expanded(
              child: FittedBox(
                child: Image.asset(widget.ressource.),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
