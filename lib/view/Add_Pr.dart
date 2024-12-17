import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_mag_poul/controlers/GarageFormController.dart';
import 'package:admin_mag_poul/widget/CustomInputField.dart';
import 'package:admin_mag_poul/widget/FileInputField.dart';

class GarageFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GarageFormController controller = Get.put(GarageFormController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Garage Form"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInputField(
              label: "Prénom",
              onChanged: (value) => controller.updateField('prenom', value),
            ),
            CustomInputField(
              label: "Nom",
              onChanged: (value) => controller.updateField('nom', value),
            ),
            CustomInputField(
              label: "Lieu",
              onChanged: (value) => controller.updateField('lieu', value),
            ),
            CustomInputField(
              label: "Surface du Garage (m²)",
              inputType: TextInputType.number,
              onChanged: (value) =>
                  controller.updateField('surfaceGarage', double.tryParse(value) ?? 0.0),
            ),
            CustomInputField(
              label: "Quantité Max Produits",
              inputType: TextInputType.number,
              onChanged: (value) =>
                  controller.updateField('quantiteMaxProduits', int.tryParse(value) ?? 0),
            ),
            CustomInputField(
              label: "Type de Volaille",
              onChanged: (value) => controller.updateField('typeVolaille', value),
            ),
            CustomInputField(
              label: "Nom du Vétérinaire",
              onChanged: (value) => controller.updateField('nomVeterinaire', value),
            ),
            // Utilisation de FileInputField pour les fichiers image ou PDF
            FileInputField(
              label: "Pièce d'Identité",
              onChanged: (value) => controller.updateField('pieceIdentite', value),
              isImagePicker: false, // Choisir le type de fichier (image ou PDF)
            ),
            FileInputField(
              label: "Chèque Barré",
              onChanged: (value) => controller.updateField('chequeBarre', value),
              isImagePicker: false, // Choisir le type de fichier (image ou PDF)
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Couleur de fond
                foregroundColor: Colors.white, // Couleur du texte
                shape: RoundedRectangleBorder( // Coins arrondis
                  borderRadius: BorderRadius.circular(12), // Ajuster le rayon ici
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding interne
                elevation: 5, // Ombre pour un effet d'élévation
              ),
              child: Text(
                "Soumettre",
                style: TextStyle(
                  fontSize: 18, // Taille du texte
                  fontWeight: FontWeight.bold, // Style gras
                  letterSpacing: 1.5, // Espacement des lettres
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
