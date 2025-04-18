import '../data/models/category_model.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> fetchCategories({required int page});
}
