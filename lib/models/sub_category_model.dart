class SubCategoryModel {
  final String id;
  final String name;
  SubCategoryModel({
    this.id,
    this.name,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> data) {
    return SubCategoryModel(
      id: data['Id'],
      name: data['Name'],
    );
  }
}
