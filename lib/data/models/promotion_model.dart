class Promotion {
  final int id;
  final String title;
  final String imageUrl;

  Promotion({required this.id, required this.title, required this.imageUrl});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
