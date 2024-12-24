import 'package:admin_mag_poul/view/Add_Pr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
class CardExampleApp extends StatelessWidget {
  const CardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card Sample'),
          backgroundColor: Colors.teal,
        ),
        body: const CardExample(),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  // Fonction pour afficher la boîte de dialogue de confirmation
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cette carte ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue sans supprimer
              },
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Carte supprimée !')),
                );
              },
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );
  }


  void _showdialgueAccepteCrd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue), // Icône ajoutée
              SizedBox(width: 10),
              const Text('Confirmation'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Êtes-vous sûr de vouloir accepter ce garage ?'),
              SizedBox(height: 20),

              // Champ pour entrer la localisation
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Localisation de l\'appareil',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Champ pour entrer l'adresse MAC
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Adresse MAC de l\'appareil',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Bouton pour télécharger un fichier PDF
              ElevatedButton(
                onPressed: () async {
                  // Fonction pour ajouter un fichier PDF (Téléchargement via navigateur)
                  await _uploadPdf(context);
                },
                child: const Text('Ajouter un fichier PDF'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue sans supprimer
              },
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Carte Accepter !')),
                );
              },
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _uploadPdf(BuildContext context) async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf';  // Limite le téléchargement aux fichiers PDF
    uploadInput.click();

    // Quand un fichier est sélectionné
    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files[0];
        // Afficher un message dans le SnackBar avec le nom du fichier ajouté
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fichier PDF ajouté : ${file.name}')),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Nom',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Prénom',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Lieu de Garage',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Type de Volaille',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(context); // Affiche la boîte de confirmation
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Delete'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(GarageFormView());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text('Update'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showdialgueAccepteCrd(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text('Accepter'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
