class UserModel {
  String title;
  String categoryName;
  String createdBy;
  String slug;
  String description;
  String createdAt;
  String role;
  num price;

  UserModel({
    required this.title,
    required this.categoryName,
    required this.createdBy,
    required this.slug,
    required this.description,
    required this.createdAt,
    required this.role,
    required this.price,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
        title: json['title'] == null ? '' : json['title'] as String,
        categoryName: json['category']['name'] == null
            ? ''
            : json['category']['name'] as String,
        createdBy: json['createdBy']['name'] == null
            ? ''
            : json['createdBy']['name'] as String,
        slug: json['category']['slug'] == null
            ? ''
            : json['category']['slug'] as String,
        description:
            json['description'] == null ? '' : json['description'] as String,
        createdAt: json['createdAt'] == null ? '' : json['createdAt'] as String,
        role: json['createdBy']['role'] == null
            ? ''
            : json['createdBy']['role'] as String,
        price: json['price'] == null ? 0 : json['price'] as num);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['category']['name'] = categoryName;
    data['createdBy']['name'] = createdBy;
    data['category']['slug'] = slug;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['createdBy']['role'] = role;
    data['price'] = price;

    return data;
  }
}
