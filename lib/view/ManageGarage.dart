import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_mag_poul/controlers/ToggleController.dart';

// Vue principale
class ManageGarage extends StatelessWidget {
  const ManageGarage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation du contrôleur
    final ToggleController controller = Get.put(ToggleController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion du Garage"),
      ),
      body: Center(
        child: Column(
          children: [
            // ToggleButtons avec GetX
            Obx(() => ToggleButtons(
              isSelected: controller.selectedStates,
              onPressed: (index) {
                controller.toggle(index);
              },
              color: Colors.black, // Couleur du texte non sélectionné
              selectedColor: Colors.white, // Couleur du texte sélectionné
              fillColor: controller.selectedStates[1]
                  ? Colors.green // Si "Accepté" est actif, vert
                  : Colors.yellow, // Sinon, jaune
              borderRadius: BorderRadius.circular(10), // Coins arrondis
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('En Attente', style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Accepté', style: TextStyle(fontSize: 16)),
                ),
              ],
            )),




          ],
        ),
      ),
    );
  }
}
