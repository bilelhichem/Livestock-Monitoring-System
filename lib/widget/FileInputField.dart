import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:get/get.dart'; // Assuming you use GetX for state management

class FileInputField extends StatelessWidget {
  final String label;
  final Function(String) onChanged; // Callback for returning the file path
  final bool isImagePicker; // If true, use ImagePicker, else use FilePicker

  const FileInputField({
    required this.label,
    required this.onChanged,
    this.isImagePicker = false, // Choose if it is for image or generic file
    Key? key,
  }) : super(key: key);

  void selectImage() {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*'; // Accepts only images
    input.onChange.listen((e) {
      final files = input.files;
      if (files?.isEmpty ?? true) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(files![0]);
      reader.onLoadEnd.listen((e) {
        final imageUrl = reader.result as String;
        onChanged(imageUrl); // Pass the image URL to the controller
      });
    });
    input.click();
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
              // Open file picker
              selectImage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Background color
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder( // Rounded corners
                borderRadius: BorderRadius.circular(12), // Adjust radius here
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Internal padding
              elevation: 5, // Shadow for elevation effect
            ),
            child: Text(isImagePicker ? 'Sélectionner une image' : 'Sélectionner un fichier'),
          ),
        ],
      ),
    );
  }
}
