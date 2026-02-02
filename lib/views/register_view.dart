import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final AuthController controller = Get.find<AuthController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text("register".tr), //  Translation key
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 60),

                //  Title
                Text(
                  "create_account".tr,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                //  Subtitle
                Text(
                  "register_subtitle".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),

                //  Name
                CustomTextField(
                  controller: nameController,
                  hint: "full_name".tr,
                  icon: Icons.person,
                ),

                //  Email
                CustomTextField(
                  controller: emailController,
                  hint: "email".tr,
                  icon: Icons.email,
                ),

                //  Password
                CustomTextField(
                  controller: passwordController,
                  hint: "password".tr,
                  icon: Icons.lock,
                  isPassword: true,
                ),

                const SizedBox(height: 25),

                //  Register Button
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    text: "register".tr,
                    onPressed: () {
                      controller.register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                    },
                  );
                }),

                const SizedBox(height: 20),

                //  Back to Login
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "already_account".tr,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
