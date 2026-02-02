import 'package:get/get.dart';
import '../core/supabase_config.dart';

class MyArtworksController extends GetxController {
  var myArtworks = [].obs;
  var isLoading = false.obs;

  // Fetch My Posts
  Future<void> fetchMyArtworks() async {
    try {
      isLoading.value = true;

      final userId =
          SupabaseConfig.client.auth.currentUser!.id;

      final data = await SupabaseConfig.client
          .from("artworks")
          .select()
          .eq("user_id", userId)
          .order("created_at", ascending: false);

      myArtworks.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //  Delete Artwork
  Future<void> deleteArtwork(String id, String mediaUrl) async {
    try {
      //  حذف المنشور من Database
      await SupabaseConfig.client
          .from("artworks")
          .delete()
          .eq("id", id);

      // حذف الصورة من Storage
      final filePath = mediaUrl.split("/").last;

      await SupabaseConfig.client.storage
          .from("artwork_media")
          .remove(["uploads/$filePath"]);

      Get.snackbar("Success", "Post deleted ✅");

      fetchMyArtworks();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  @override
  void onInit() {
    fetchMyArtworks();
    super.onInit();
  }
}
