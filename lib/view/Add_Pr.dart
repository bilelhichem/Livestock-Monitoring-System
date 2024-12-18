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
            FileInputField(
              label: "Pièce d'Identité",
              onChanged: (value) => controller.updateField('pieceIdentite', value),
              isImagePicker: true,
            ),
            FileInputField(
              label: "Chèque Barré",
              onChanged: (value) => controller.updateField('chequeBarre', value),
              isImagePicker: false,
            ),
            Obx(() {
              // Display the image if the path is valid
              if (controller.pieceIdentiteImagePath.value.isNotEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(controller.pieceIdentiteImagePath.value,width: 100,height: 100,),
                    Image.network(controller.chequeBarreImagePath.value,width: 100,height: 100,),

                  ],
                ); // Display the image from the URL
              }
              return Text("Aucune image sélectionnée"); // Display message if no file is selected
            }),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder( // Rounded corners
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                elevation: 5,
              ),
              child: Text(
                "Soumettre",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
