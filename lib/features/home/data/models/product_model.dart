class ProductModel {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String coverPictureUrl;
  final int? stock;
  final List<String> categoryIds;
  final List<String>? productPictureUrls;
  final String sellerId;
  final String? nameArabic;
  final String? color;
  final String? descriptionArabic;
  final double rating;
  final int reviewsCount;
  final double discountPercentage;
  final double weight;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.coverPictureUrl,
    required this.stock,
    required this.categoryIds,
    this.productPictureUrls,
    required this.sellerId,
    this.nameArabic,
    this.color,
    this.descriptionArabic,
    this.rating = 0,
    this.reviewsCount = 0,
    this.discountPercentage = 0,
    this.weight = 3581.52,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawCategories = json['categoryIds'] ?? json['categories'];
    final categoryIds = rawCategories is List
        ? rawCategories
              .map((category) {
                if (category is Map) {
                  return (category['id'] ??
                          category['slug'] ??
                          category['name'])
                      ?.toString();
                }
                return category.toString();
              })
              .whereType<String>()
              .toList()
        : <String>[];
    final rawPictures = json['productPictureUrls'] ?? json['productPictures'];

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      coverPictureUrl: json['coverPictureUrl'] ?? '',
      categoryIds: categoryIds,
      stock: (json['stock'] as num?)?.toInt(),
      productPictureUrls: rawPictures is List
          ? rawPictures.map((picture) => picture.toString()).toList()
          : null,
      sellerId: json['sellerId']?.toString() ?? '',
      nameArabic: json['nameArabic'] ?? json['arabicName'],
      color: json['color'] ?? '',
      descriptionArabic: json['descriptionArabic'] ?? json['arabicDescription'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 3581.52,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'name': name,
      'description': description,
      'price': price,
      'coverPictureUrl': coverPictureUrl,
      'stock': stock,
      'categoryIds': categoryIds,
      'productPictureUrls': productPictureUrls,
      'nameArabic': nameArabic,
      'color': color,
      'descriptionArabic': descriptionArabic,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
      'weight': weight,
    };
  }
}
