import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:convert';

class RealiserPdf {
  static Future<void> generateAndDownloadPdf(Map<String, dynamic> formData) async {
    final pdf = pw.Document();

    // Charger le logo prédéfini (fichier local ou URL)

    // Charger les autres images si nécessaires
    final pieceIdentiteImage = await _loadImage(formData['pieceIdentite']);
    final chequeBarreImage = await _loadImage(formData['chequeBarre']);

    // Ajouter du contenu au PDF
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Center(
                child: pw.Text(
                  'Livestock Monitoring System',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),

              // Introduction au contrat
              pw.Text(
                'Ce contrat définit les règles et engagements entre les parties pour les services mentionnés ci-dessous.',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 20),

              // Détails du client
              pw.Text(
                'Je soussigné(e), ${formData['prenom']} ${formData['nom']}, atteste posséder :',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.Bullet(
                text: 'Un garage situé à : ${formData['lieu']}, d\'une surface de ${formData['surfaceGarage']} m².',
              ),
              pw.Bullet(
                text: 'Spécialisé dans : ${formData['typeVolaille']}.',
              ),
              pw.Bullet(
                text: 'Capacité maximale : ${formData['quantiteMaxProduits']} unités.',
              ),
              pw.Bullet(
                text: 'Supervisé par : ${formData['nomVeterinaire']}.',
              ),
              pw.SizedBox(height: 20),

              // Accord de paiement
              pw.Text(
                'Pour ce contrat, je m\'engage à payer la somme de 2 millions et à respecter les termes d\'abonnement.',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),

              // Documents fournis
              pw.Text('Documents fournis :', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),

              // Pièce d'identité
              pieceIdentiteImage != null
                  ? pw.Container(
                decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                padding: const pw.EdgeInsets.all(8),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Pièce d\'Identité :', style: pw.TextStyle(fontSize: 12)),
                    pw.Image(pieceIdentiteImage, width: 150, height: 100),
                  ],
                ),
              )
                  : pw.Text('Pièce d\'Identité : Aucune image fournie', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 10),

              // Chèque barré
              chequeBarreImage != null
                  ? pw.Container(
                decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                padding: const pw.EdgeInsets.all(8),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Chèque Barré :', style: pw.TextStyle(fontSize: 12)),
                    pw.Image(chequeBarreImage, width: 150, height: 100),
                  ],
                ),
              )
                  : pw.Text('Chèque Barré : Aucun image fourni', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 30),

              // Section footer
              pw.Text('Fait à : ${formData['lieu']}', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 20),
              pw.Text('Signature du client :', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 50),
              pw.Divider(thickness: 1, color: PdfColors.black),
            ],
          );
        },
      ),
    );

    // Sauvegarder le PDF sous forme de Uint8List
    final pdfBytes = await pdf.save();

    // Créer un Blob à partir des bytes du PDF
    final blob = html.Blob([Uint8List.fromList(pdfBytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Créer un élément d'ancrage pour déclencher le téléchargement
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'contrat_professionnel.pdf';

    // Déclencher le téléchargement
    anchor.click();

    // Nettoyer
    html.Url.revokeObjectUrl(url);
  }

  // Charger une image (depuis un chemin ou URL)
  static Future<pw.ImageProvider?> _loadImage(String imagePath) async {
    if (imagePath.isEmpty) {
      return null;
    }

    try {
      final bytes = await _getImageBytes(imagePath);
      return pw.MemoryImage(bytes);
    } catch (e) {
      print("Erreur lors du chargement de l'image : $e");
      return null;
    }
  }

  // Obtenir les bytes d'une image depuis un fichier ou URL
  static Future<Uint8List> _getImageBytes(String imagePath) async {
    try {
      if (imagePath.startsWith('data:image')) {
        final parts = imagePath.split(',');
        return base64.decode(parts[1]);
      } else {
        final response = await html.HttpRequest.request(imagePath, responseType: 'arraybuffer');
        return response.response as Uint8List;
      }
    } catch (e) {
      print("Erreur lors de la récupération des bytes de l'image : $e");
      return Uint8List(0); // Retourner vide en cas d'erreur
    }
  }
}
