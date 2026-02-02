import 'package:get/get.dart';
import '../core/supabase_config.dart';
import '../models/artwork_model.dart';
import '../controllers/artwork_controller.dart';

class ArtworkController extends GetxController {
  var artworks = <ArtworkModel>[].obs;
  var isLoading = false.obs;


  //  جلب الأعمال من قاعدة البيانات
  Future<void> fetchArtworks() async {
    try {
      isLoading.value = true;

      final data = await SupabaseConfig.client
          .from("artworks")
          .select()
          .order("created_at", ascending: false);

      //  عرض كل الأعمال بدون فلترة
      artworks.value =
          data.map((e) => ArtworkModel.fromJson(e)).toList();

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }

  }


  @override
  void onInit() {
    fetchArtworks();
    super.onInit();
  }
}
