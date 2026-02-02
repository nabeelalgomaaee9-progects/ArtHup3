import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_artworks_controller.dart';

class MyArtworksView extends StatelessWidget {
  MyArtworksView({super.key});

  final MyArtworksController controller =
  Get.put(MyArtworksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_posts".tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.myArtworks.isEmpty) {
          return Center(
            child: Text("no_posts".tr),
          );
        }

        return ListView.builder(
          itemCount: controller.myArtworks.length,
          itemBuilder: (context, index) {
            final artwork = controller.myArtworks[index];

            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  artwork["media_url"],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(artwork["title"]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.deleteArtwork(
                        artwork["id"],
                        artwork["media_url"],
                      );
                    },


                ),
              ),
            );
          },
        );
      }),
    );
  }
}
