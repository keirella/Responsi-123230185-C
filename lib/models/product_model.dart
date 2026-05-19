class ProductModel {
  final String id; 
  final String name;
  final int playtime;
  final String released;
  final int tba;
  final double rating;
  final int rating_count;
  final int review_count;
  final String created_at;
  final String update_at;
  final String background_image;

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
    required this.background_image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '', 
      name: json['name'] ?? '',
      playtime: json['playtime'] ?? 0,
      released: json['released']?.toString() ?? '-',
      tba: json['tba'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      rating_count: json['ratings_count'] ?? 0,
      review_count: json['reviews_count'] ?? 0,
      created_at: json['created_at']?.toString() ?? '-',
      update_at: json['updated_at']?.toString() ?? '-',
      background_image: json['background_image']?.toString() ?? '',
    );
  }
}