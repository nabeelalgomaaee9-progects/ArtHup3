import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/artwork_controller.dart';
import 'artwork_details_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ArtworkController controller =
  Get.put(ArtworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  Translation key only
        title: Text("feed_title".tr),
        centerTitle: true,

        //  Language Button
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

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.artworks.isEmpty) {
          return Center(
            child: Text(
              "no_artworks".tr, //  Translation
              style: const TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.artworks.length,
          itemBuilder: (context, index) {
            final artwork = controller.artworks[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    artwork.mediaUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                //  Dynamic title from DB (no translation)
                title: Text(
                  artwork.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                //  Dynamic description from DB (no translation)
                subtitle: Text(
                  artwork.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                //  Navigate to Details
                onTap: () {
                  Get.to(
                        () => ArtworkDetailsView(),
                    arguments: artwork,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
