import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../controllers/auth_controller.dart';
import 'my_artworks_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller =
  Get.put(ProfileController());

  final AuthController authController =
  Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  Drawer Menu
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: Obx(() => Text(controller.name.value)),
              accountEmail: Obx(() => Text(controller.email.value)),
              currentAccountPicture: Obx(() {
                return CircleAvatar(
                  backgroundImage: controller.profileImage.value.isNotEmpty
                      ? NetworkImage(controller.profileImage.value)
                      : null,
                  child: controller.profileImage.value.isEmpty
                      ? const Icon(Icons.person, size: 35)
                      : null,
                );
              }),
            ),

            //  My Posts Page
            ListTile(
              leading: const Icon(Icons.image),
              title: Text("my_posts".tr),
              onTap: () {
                Get.back(); //  يغلق الـ Drawer أولاً
                Get.to(() => MyArtworksView()); //  ثم ينتقل
              },

            ),

            //  Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text("logout".tr),
              onTap: () {
                authController.logout();
              },
            ),
          ],
        ),
      ),

      //  Profile Screen Content
      appBar: AppBar(
        title: Text("profile".tr),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.changeProfileImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.deepPurple,
                  backgroundImage: controller.profileImage.value.isNotEmpty
                      ? NetworkImage(controller.profileImage.value)
                      : null,
                  child: controller.profileImage.value.isEmpty
                      ? const Icon(Icons.camera_alt,
                      size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 15),

              Text(
                controller.name.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                controller.email.value,
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              Text(
                "open_drawer".tr,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
