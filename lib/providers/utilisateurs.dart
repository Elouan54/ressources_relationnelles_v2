import 'package:uuid/uuid.dart';

class Utilisateurs {
  String? idUser = const Uuid().v4();
  String pseudo;
  String email;
  String mdp;
  String dateNaissance;
  String nom;
  String nomJeuneFille;
  String prenom;
  //Langue langue;
  String derniereDateConnexion;
  bool validationRgpd;
  String dateValidationRgpd;
  bool accordConfidentialite;
  String dateAccordConfidentialite;
  String numeroTelephone;
  //TypeUtilisateur typeUtilisateur;

  Utilisateurs(
      {required this.idUser,
      required this.pseudo,
      required this.email,
      required this.mdp,
      required this.dateNaissance,
      required this.nom,
      required this.nomJeuneFille,
      required this.prenom,
      //required this.langue,
      required this.derniereDateConnexion,
      required this.validationRgpd,
      required this.dateValidationRgpd,
      required this.accordConfidentialite,
      required this.dateAccordConfidentialite,
      required this.numeroTelephone});
  //required this.typeUtilisateur});
}
