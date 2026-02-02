import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/artwork_model.dart';
import 'comments_view.dart';

class ArtworkDetailsView extends StatelessWidget {
  ArtworkDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtworkModel artwork = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text("details".tr), // ✅ Translation key
        centerTitle: true,

        // ✅ Language Button
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              if (Get.locale!.languageCode == "en") {
                Get.updateLocale(const Locale("ar"));
              } else {
                Get.updateLocale(const Locale("en"));
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ✅ Artwork Image
            Image.network(
              artwork.mediaUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // ✅ Title (dynamic, no translation)
            Text(
              artwork.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Description (dynamic, no translation)
            Text(
              artwork.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // ✅ Comments Button
            ElevatedButton(
              onPressed: () {
                Get.to(() => CommentsView(
                  artworkId: artwork.id,
                ));
              },
              child: Text("view_comments".tr), // ✅ Translation
            ),
          ],
        ),
      ),
    );
  }
}
