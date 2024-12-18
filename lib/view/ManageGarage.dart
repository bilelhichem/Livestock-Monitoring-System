import 'package:admin_mag_poul/widget/RechercheCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_mag_poul/controlers/ToggleController.dart';

import '../widget/CardGarage.dart';


class ManageGarage extends StatelessWidget {
  const ManageGarage({super.key});

  @override
  Widget build(BuildContext context) {

    final ToggleController controller = Get.put(ToggleController());
    final RxInt ind = 0.obs ;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Gestion du Garage"),
      ),
      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(10.0),
          child: Column(



            children: [

              SearchUIDesign(),

              Obx(() => ToggleButtons(
                isSelected: controller.selectedStates,
                onPressed: (index) {
                  controller.toggle(index);
                  ind.value = index;







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


              Obx(() => ind.value == 0
                  ? const CardExample()
                  : const   SizedBox())



            ],
          ),
        ),
      ),
    );
  }
}
