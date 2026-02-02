import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../core/supabase_config.dart';
import '../controllers/artwork_controller.dart';


class AddArtworkController extends GetxController {
  var isLoading = false.obs;

  File? selectedImage;

  //  اختيار صورة
  Future<void> pickImage() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file != null) {
      selectedImage = File(file.path);
      update();
    }
  }

  // ✅ رفع صورة + حفظ العمل الفني
  Future<void> uploadArtwork(
      String title,
      String description,
      ) async {

    if (selectedImage == null) {
      Get.snackbar("خطأ", "اختر صورة أولاً");
      return;
    }

    try {
      isLoading.value = true;

      //  ID المستخدم الحالي
      final userId =
          SupabaseConfig.client.auth.currentUser!.id;

      //  اسم ملف فريد للصورة
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}.png";

      //  رفع الصورة داخل Storage
      await SupabaseConfig.client.storage
          .from("artwork_media")
          .upload("uploads/$fileName", selectedImage!);

      //  رابط الصورة العام
      final imageUrl =
      SupabaseConfig.client.storage
          .from("artwork_media")
          .getPublicUrl("uploads/$fileName");

      //  إدخال بيانات العمل الفني في جدول artworks
      await SupabaseConfig.client.from("artworks").insert({
        "title": title,
        "description": description,
        "media_url": imageUrl,
        "user_id": userId,
      });

      Get.snackbar("نجاح ", "تم رفع العمل الفني!");
      Get.find<ArtworkController>().fetchArtworks();

// رجوع للرئيسية

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
