class CategoryModel {
  final String id;
  final String name;
  final String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: 'sports', name: 'sports', imageName: 'sports'),
    CategoryModel(id: 'music', name: 'music', imageName: 'music'),
    CategoryModel(id: 'movies', name: 'movies', imageName: 'chat_movie'),
  ];
}
