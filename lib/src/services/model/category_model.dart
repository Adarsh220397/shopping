class CategoryModel {
  String image;
  String categoryName;

  CategoryModel({
    required this.image,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      image: json['image'] == null ? '' : json['image'] as String,
      categoryName:
          json['categoryName'] == null ? '' : json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['categoryName'] = categoryName;

    return data;
  }
}
