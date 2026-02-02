import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_view.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("verify_email".tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email_outlined,
              size: 90,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 25),

            Text(
              "check_email".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Get.offAll(() => LoginView());
              },
              child: Text("back_login".tr),
            ),
          ],
        ),
      ),
    );
  }
}
