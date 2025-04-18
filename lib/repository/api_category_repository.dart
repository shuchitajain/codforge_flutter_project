import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../data/models/category_model.dart';
import 'category_repository.dart';

class ApiCategoryRepository implements ICategoryRepository {
  static const String _apiUrl =
      'https://mocki.io/v1/4d0fa379-df4a-410d-9c4f-299d59eefb8e';
  static const int _pageSize = 10;

  List<CategoryModel>? _categories;

  @override
  Future<List<CategoryModel>> fetchCategories({required int page}) async {
    try {
      // Load once and cache fetched categories
      _categories ??= await _loadAllCategories();

      final start = page * _pageSize;
      if (start >= _categories!.length) return [];

      final end = (start + _pageSize).clamp(
        0,
        _categories!.length,
      ); //Clamping to avoid overflow
      return _categories!.sublist(start, end);
    } catch (e) {
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

  Future<List<CategoryModel>> _loadAllCategories() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final List decoded = json.decode(response.body);
        return decoded.map((e) => CategoryModel.fromMap(e)).toList();
      }

      switch (response.statusCode) {
        case 404:
          throw Exception('Categories not found (404)');
        case 500:
          throw Exception('Server error (500)');
        default:
          throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    } on HttpException {
      throw Exception('Unexpected HTTP error');
    }
  }
}
