class ProductModel {
  final int id;
  final String name;
  final int playtime;
  final String released;
  final int tba;
  final int rating;
  final int rating_count;
  final int review_count;
  final String created_at;
  final String update_at;
  final List<String> background_images;

  ProductModel({
    required this.id,
    required this.name,
    required this.playtime,
    required this.released,
    required this.tba,
    required this.rating,
    required this.rating_count,
    required this.review_count,
    required this.created_at,
    required this.update_at,
    required this.background_images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      playtime: json['playtime'] ?? '',
      released: json['released'] ?? '',
      rating: json['rating'] ?? '',
      tba: (json['tba'] ?? 0).toDouble(),
      rating_count: json['rating_count'] ?? '',
      review_count: json['rating_count'] ?? '',
      created_at: json['created_at'] ?? '',
      update_at: json['update_at'] ?? 0,
      background_images: List<String>.from(json['background_images'] ?? []),
    );
  }
}
