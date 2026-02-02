import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/comment_controller.dart';

class CommentsView extends StatelessWidget {
  final String artworkId;

  CommentsView({super.key, required this.artworkId});

  final CommentController controller =
  Get.put(CommentController());

  final commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.fetchComments(artworkId);

    return Scaffold(
      appBar: AppBar(
        title: Text("comments".tr), // Translation
        centerTitle: true,
      ),

      body: Column(
        children: [
          //  Comments List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.comments.isEmpty) {
                return Center(
                  child: Text("no_comments".tr), //  Translation
                );
              }

              return ListView.builder(
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final comment = controller.comments[index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(comment.text), //  Dynamic text
                  );
                },
              );
            }),
          ),

          //  Add Comment Section
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentTextController,
                    decoration: InputDecoration(
                      hintText: "write_comment".tr, //  Translation
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    controller.addComment(
                      artworkId,
                      commentTextController.text,
                    );

                    commentTextController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
