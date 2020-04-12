class CategoryTypeModel {
  final String id;
  final String name;
  CategoryTypeModel({
    this.id,
    this.name,
  });

  factory CategoryTypeModel.fromJson(Map<String, dynamic> data) {
    return CategoryTypeModel(
      id: data['Id'],
      name: data['Name'],
    );
  }
}
