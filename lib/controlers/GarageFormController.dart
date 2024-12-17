import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:admin_mag_poul/data/models/Garage_info_model.dart';

class GarageFormController extends GetxController {
  var garageForm = GarageInfo(
    prenom: '',
    nom: '',
    lieu: '',
    surfaceGarage: 0.0,
    quantiteMaxProduits: 0,
    typeVolaille: '',
    nomVeterinaire: '',
    pieceIdentite: '',
    chequeBarre: '',
  ).obs;

  void updateField(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'prenom':
        garageForm.update((form) => form!.prenom = value);
        break;
      case 'nom':
        garageForm.update((form) => form!.nom = value);
        break;
      case 'lieu':
        garageForm.update((form) => form!.lieu = value);
        break;
      case 'surfaceGarage':
        garageForm.update((form) => form!.surfaceGarage = value);
        break;
      case 'quantiteMaxProduits':
        garageForm.update((form) => form!.quantiteMaxProduits = value);
        break;
      case 'typeVolaille':
        garageForm.update((form) => form!.typeVolaille = value);
        break;
      case 'nomVeterinaire':
        garageForm.update((form) => form!.nomVeterinaire = value);
        break;
      case 'pieceIdentite':
        garageForm.update((form) => form!.pieceIdentite = value);
        break;
      case 'chequeBarre':
        garageForm.update((form) => form!.chequeBarre = value);
        break;
      default:
        throw Exception("Champ inconnu : $fieldName");
    }
  }

  void submitForm() {
    if (_validateForm()) {
      print("Formulaire soumis avec succès : ${garageForm.value}");
    } else {
      Get.snackbar("Erreur", "Veuillez remplir tous les champs correctement.");
    }
  }

  bool _validateForm() {
    final form = garageForm.value;
    return form.prenom.isNotEmpty &&
        form.nom.isNotEmpty &&
        form.lieu.isNotEmpty &&
        form.surfaceGarage > 0 &&
        form.quantiteMaxProduits > 0 &&
        form.typeVolaille.isNotEmpty &&
        form.nomVeterinaire.isNotEmpty &&
        form.pieceIdentite != null &&
        form.chequeBarre != null;
  }
}
