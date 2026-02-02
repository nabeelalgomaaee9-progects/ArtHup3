import 'package:get/get.dart';
import '../core/supabase_config.dart';
import '../models/comment_model.dart';

class CommentController extends GetxController {
  var comments = <CommentModel>[].obs;
  var isLoading = false.obs;

  //  جلب التعليقات الخاصة بعمل فني
  Future<void> fetchComments(String artworkId) async {
    try {
      isLoading.value = true;

      final data = await SupabaseConfig.client
          .from("comments")
          .select()
          .eq("artwork_id", artworkId)
          .order("created_at", ascending: false);

      comments.value =
          data.map((e) => CommentModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //  إضافة تعليق جديد
  Future<void> addComment(String artworkId, String text) async {
    try {
      final userId =
          SupabaseConfig.client.auth.currentUser!.id;

      await SupabaseConfig.client.from("comments").insert({
        "comment_text": text,
        "artwork_id": artworkId,
        "user_id": userId,
      });

      fetchComments(artworkId);

      Get.snackbar("Success", "Comment added ✅");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
