import 'package:flutter/material.dart';

class Statistiques extends StatefulWidget {
  const Statistiques({super.key});

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  final List<Map<String, dynamic>> listInscriptions = [
    {'date': '2023-04-20', 'inscriptions': 5},
    {'date': '2023-04-21', 'inscriptions': 10},
    {'date': '2023-04-22', 'inscriptions': 8},
    {'date': '2023-04-23', 'inscriptions': 15},
    {'date': '2023-04-24', 'inscriptions': 12},
    {'date': '2023-04-25', 'inscriptions': 18},
    {'date': '2023-04-26', 'inscriptions': 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistiques"),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Statistiques d'inscriptions par jour",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: listInscriptions.length,
                itemBuilder: (context, index) {
                  final registration = listInscriptions[index];
                  return ListTile(
                    title: Text(registration['date']),
                    subtitle:
                        Text("Inscriptions : ${registration['inscriptions']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
