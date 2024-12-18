import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/services.dart';

class RealiserPdf {
  static Future<void> generateAndDownloadPdf(Map<String, dynamic> formData) async {
    final pdf = pw.Document();

    // Load images from the paths (for web, you can load from URLs or base64 strings)
    final pieceIdentiteImage = await _loadImage(formData['pieceIdentite']);
    final chequeBarreImage = await _loadImage(formData['chequeBarre']);

    // Add your content here
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Prénom: ${formData['prenom']}'),
              pw.Text('Nom: ${formData['nom']}'),
              pw.Text('Lieu: ${formData['lieu']}'),
              pw.Text('Surface Garage: ${formData['surfaceGarage']}'),
              pw.Text('Quantité Max Produits: ${formData['quantiteMaxProduits']}'),
              pw.Text('Type Volaille: ${formData['typeVolaille']}'),
              pw.Text('Nom Vétérinaire: ${formData['nomVeterinaire']}'),
              pw.Text('Pièce Identité:'),
              pieceIdentiteImage != null
                  ? pw.Image(pieceIdentiteImage,width: 100,height: 100) // Include the image in the PDF
                  : pw.Text('Aucune image sélectionnée'),
              pw.Text('Chèque Barré:'),
              chequeBarreImage != null
                  ? pw.Image(chequeBarreImage,width: 100,height: 100) // Include the image in the PDF
                  : pw.Text('Aucune image sélectionnée'),
            ],
          );
        },
      ),
    );

    // Save PDF to Uint8List
    final pdfBytes = await pdf.save();

    // Create Blob from PDF bytes
    final blob = html.Blob([Uint8List.fromList(pdfBytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element to trigger the download
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'form_data.pdf';

    // Trigger the download
    anchor.click();

    // Cleanup
    html.Url.revokeObjectUrl(url);
  }

  // Load image (from URL or base64 string)
  static Future<pw.ImageProvider?> _loadImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) {
      return null;
    }

    // If image is a URL, use ImageProvider
    try {
      final bytes = await _getImageBytes(imagePath);
      return pw.MemoryImage(bytes);
    } catch (e) {
      print("Error loading image: $e");
      return null;
    }
  }

  // Get the image bytes from the file or URL
  static Future<Uint8List> _getImageBytes(String imagePath) async {
    try {
      // For a base64 string
      if (imagePath.startsWith('data:image')) {
        final parts = imagePath.split(',');
        return base64.decode(parts[1]);
      }
      // For a URL or path
      else {
        final response = await html.HttpRequest.request(imagePath, responseType: 'arraybuffer');
        return response.response as Uint8List;
      }
    } catch (e) {
      print("Error fetching image bytes: $e");
      return Uint8List(0); // Return empty if error
    }
  }
}
