import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_artwork_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class AddArtworkView extends StatelessWidget {
  AddArtworkView({super.key});

  final AddArtworkController controller =
  Get.put(AddArtworkController());

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text("add_artwork".tr), // ✅ Translation key
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GetBuilder<AddArtworkController>(
              builder: (_) {
                return Column(
                  children: [
                    // ✅ Image Picker Box
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: controller.selectedImage == null
                            ? Center(
                          child: Text(
                            "choose_image".tr, // ✅ Translation
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            controller.selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ✅ Artwork Title
                    CustomTextField(
                      controller: titleController,
                      hint: "artwork_title".tr, // ✅ Translation
                      icon: Icons.title,
                    ),

                    // ✅ Description
                    CustomTextField(
                      controller: descController,
                      hint: "artwork_description".tr, // ✅ Translation
                      icon: Icons.description,
                    ),

                    const SizedBox(height: 25),

                    // ✅ Upload Button
                    Obx(() {
                      return controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : CustomButton(
                        text: "upload".tr, // ✅ Translation
                        onPressed: () {
                          controller.uploadArtwork(
                            titleController.text,
                            descController.text,
                          );
                        },
                      );
                    }),

                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
