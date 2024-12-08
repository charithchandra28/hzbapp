class Promotion {
  final int id;
  final String title;
  final String imageUrl;
  final String description;

  Promotion({required this.id, required this.title, required this.imageUrl,required this.description,});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
        description : json['description']
    );
  }
}
