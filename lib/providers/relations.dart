class Relation {
  int idRelationUtilisateurs;
  int utilisateur;
  int utilisateurVoulu;
  String typeRelation;
  bool relationConfirmee;

  Relation(
      {required this.idRelationUtilisateurs,
      required this.utilisateur,
      required this.utilisateurVoulu,
      required this.typeRelation,
      required this.relationConfirmee});
}
