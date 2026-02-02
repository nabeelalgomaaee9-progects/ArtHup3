class CommentModel {
  final String id;
  final String text;
  final String userId;

  CommentModel({
    required this.id,
    required this.text,
    required this.userId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      text: json["comment_text"],
      userId: json["user_id"],
    );
  }
}
