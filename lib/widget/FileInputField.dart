import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileInputField extends StatelessWidget {
  final String label;
  final Function(String) onChanged; // Callback pour retourner le chemin du fichier sélectionné
  final bool isImagePicker; // Si true, utilise ImagePicker, sinon FilePicker

  const FileInputField({
    required this.label,
    required this.onChanged,
    this.isImagePicker = false, // Choisir si c'est pour image ou fichier générique
    Key? key,
  }) : super(key: key);

  // Fonction pour choisir un fichier (image ou PDF)
  Future<void> _pickFile(BuildContext context) async {
    // Ouvre le sélecteur de fichier via file_picker
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Sélection de tout type de fichier
      allowedExtensions: isImagePicker ? ['jpg', 'jpeg', 'png'] : ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      // Retourne le chemin du fichier sélectionné
      onChanged(result.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aucun fichier sélectionné')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Ouvre le sélecteur de fichier
              _pickFile(context);
            },
            child: Text(isImagePicker ? 'Sélectionner une image' : 'Sélectionner un fichier'),
          ),
        ],
      ),
    );
  }
}
