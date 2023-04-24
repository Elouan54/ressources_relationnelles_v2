import 'package:ressources_relationnelles_v2/screens/profil.dart';
import 'package:ressources_relationnelles_v2/screens/ressource.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'moderation.dart';
import 'recherche.dart';

class PrincipalMaster extends StatefulWidget {
  const PrincipalMaster({super.key});

  @override
  State<PrincipalMaster> createState() => _PrincipalMasterState();
}

class _PrincipalMasterState extends State<PrincipalMaster> {
  late int _selectedIndex = 0;

  int? role;

  getRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role');
      //print("role = " + role.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    //print('initState');
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    final listeLiens = [
      const Ressource(),
      const Recherche(),
      const Profil(),
      const Moderation(),
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Column(
          children: <Widget>[
            Image.asset("assets/logo.png", width: 100, height: 100),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 3, 152, 158), //03989E
        //automaticallyImplyLeading: false,
      ),
      body: listeLiens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: const Color.fromARGB(255, 3, 152, 158),
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Ressources',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
          if (role == 2) ...[
            const BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Moderation',
            ),
          ],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    getRole();
  }
}
