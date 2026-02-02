import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController controller = Get.find<AuthController>();


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text("login".tr), //  Translation key
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

                //  App Name (يمكن تركه بدون ترجم
                Text(
                  "app_name".tr,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                //  Subtitle
                Text(
                  "login_subtitle".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),

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

                const SizedBox(height: 20),

                //  Login Button
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    text: "login".tr,
                    onPressed: () {
                      controller.login(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                  );
                }),

                const SizedBox(height: 15),

                //  Register Link
                TextButton(
                  onPressed: () {
                    Get.to(() => RegisterView());
                  },
                  child: Text("dont_have_account".tr),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
