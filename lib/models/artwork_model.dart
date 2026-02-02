class ArtworkModel {
  final String id;
  final String title;
  final String description;
  final String mediaUrl;

  ArtworkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      mediaUrl: json['media_url'],
    );
  }
}
