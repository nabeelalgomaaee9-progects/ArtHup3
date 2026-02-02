import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/supabase_config.dart';

class ProfileController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var profileImage = "".obs;

  var isLoading = false.obs;

  //  جلب بيانات المستخدم
  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;

      final userId =
          SupabaseConfig.client.auth.currentUser!.id;

      final data = await SupabaseConfig.client
          .from("users")
          .select()
          .eq("id", userId)
          .single();

      name.value = data["name"];
      email.value = data["email"];
      profileImage.value = data["profile_image"] ?? "";
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //  تغيير صورة الملف الشخصي
  Future<void> changeProfileImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (picked == null) return;

    File file = File(picked.path);

    try {
      isLoading.value = true;

      final userId =
          SupabaseConfig.client.auth.currentUser!.id;

      final fileName = "$userId-profile.png";

      //  رفع الصورة في Storage
      await SupabaseConfig.client.storage
          .from("profile_images")
          .upload(
        "users/$fileName",
        file,
      );


      //  رابط الصورة
      final imageUrl = SupabaseConfig.client.storage
          .from("profile_images")
          .getPublicUrl("users/$fileName");

      //  تحديث الجدول users
      await SupabaseConfig.client.from("users").update({
        "profile_image": imageUrl,
      }).eq("id", userId);

      profileImage.value = imageUrl;

      Get.snackbar("Success", "Profile image updated ✅");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }
}
