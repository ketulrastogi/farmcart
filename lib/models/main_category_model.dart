class MainCategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  MainCategoryModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory MainCategoryModel.fromJson(Map<String, dynamic> data) {
    return MainCategoryModel(
      id: data['Id'],
      name: data['Name'],
      imageUrl: data['image'],
    );
  }
}
