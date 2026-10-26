class ProductModel {
  final String id;
  final String name;
  final String arabicName;
  final String description;
  final String arabicDescription;
  final String productCode;
  final String coverPictureUrl;
  final String color;
  final List<String> categories;
  final num price;
  final num rating;
  final int discountPercentage;
  final int reviewsCount;
  final int stock;
  final num weight;
  final List<String>? productPictures;
  final String sellerId;

  const ProductModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.productCode,
    required this.coverPictureUrl,
    required this.color,
    required this.categories,
    required this.price,
    required this.rating,
    required this.discountPercentage,
    required this.reviewsCount,
    required this.stock,
    required this.weight,
    required this.productPictures,
    required this.sellerId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      arabicName: json['arabicName'] ?? '',
      description: json['description'] ?? '',
      arabicDescription: json['arabicDescription'] ?? '',
      productCode: json['productCode'] ?? '',
      coverPictureUrl: json['coverPictureUrl'] ?? '',
      color: json['color'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      price: json['price'] ?? 0,
      rating: json['rating'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      stock: json['stock'] ?? 0,
      weight: json['weight'] ?? 0,
      productPictures: json['productPictures'] == null
          ? null
          : List<String>.from(json['productPictures']),
      sellerId: json['sellerId'] ?? '',
    );
  }
}