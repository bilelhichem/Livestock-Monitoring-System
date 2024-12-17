class GarageInfo {
  String prenom;
  String nom;
  String lieu;
  double surfaceGarage;
  int quantiteMaxProduits;
  String typeVolaille;
  String nomVeterinaire;
  String? pieceIdentite;
  String? chequeBarre;

  GarageInfo({
    required this.prenom,
    required this.nom,
    required this.lieu,
    required this.surfaceGarage,
    required this.quantiteMaxProduits,
    required this.typeVolaille,
    required this.nomVeterinaire,
    this.pieceIdentite,
    this.chequeBarre,
  });
}
