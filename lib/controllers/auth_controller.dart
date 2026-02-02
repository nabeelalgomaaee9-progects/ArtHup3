import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_config.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/navigation_view.dart';
import '../views/verify_email_view.dart';



class AuthController extends GetxController {
  final SupabaseClient client = SupabaseConfig.client;

  var isLoading = false.obs;

  //  تسجيل دخول
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.snackbar("Success", "Logged in successfully ✅");

        //  بعد تسجيل الدخول ينتقل إلى Home
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAll(() => const NavigationView());
        });
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  //  إنشاء حساب
  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;

      //  إنشاء الحساب في Supabase Auth
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final userId = response.user!.id;

      // حفظ بيانات المستخدم في جدول users
      await client.from("users").insert({
        "id": userId,
        "name": name,
        "email": email,
      });

      Get.snackbar("Success", "Account created ✅");

      //  بعد التسجيل يرجع إلى صفحة Login
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAll(() => VerifyEmailView());
      });

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //  تسجيل خروج
  Future<void> logout() async {
    await client.auth.signOut();

    //  حذف كل الكنترولرات حتى تتحدث البيانات
    Get.deleteAll();

    //  إعادة إنشاء AuthController
    Get.put(AuthController());

    Get.offAll(() => LoginView());
  }


}
