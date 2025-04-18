import 'dart:async';
import 'category_repository.dart';
import '../../../data/models/category_model.dart';
import '../../core/constants/strings.dart';

// This class simulates a category repository for testing purposes
class MockCategoryRepository implements ICategoryRepository {
  static const int _pageSize = 10;

  final Map<String, String> categoryIconMap = {
    AppStrings.fertilizers:
        'https://cdn-icons-png.flaticon.com/512/1998/1998675.png',
    AppStrings.seeds: 'https://cdn-icons-png.flaticon.com/512/2900/2900310.png',
    AppStrings.irrigationTools:
        'https://cdn-icons-png.flaticon.com/512/2659/2659980.png',
    AppStrings.requestsAndOffers:
        'https://cdn-icons-png.flaticon.com/512/891/891419.png',
    AppStrings.agriculturalTools:
        'https://cdn-icons-png.flaticon.com/512/2012/2012699.png',
    AppStrings.agriculturalBasins:
        'https://cdn-icons-png.flaticon.com/512/4359/4359970.png',
    AppStrings.cropProtection:
        'https://cdn-icons-png.flaticon.com/512/4309/4309483.png',
    AppStrings.farmMachinery:
        'https://cdn-icons-png.flaticon.com/512/1030/1030870.png',
    AppStrings.greenhouses:
        'https://cdn-icons-png.flaticon.com/512/861/861162.png',
    AppStrings.livestock:
        'https://cdn-icons-png.flaticon.com/512/616/616408.png',
    AppStrings.soil: 'https://cdn-icons-png.flaticon.com/512/2713/2713814.png',
    AppStrings.compost:
        'https://cdn-icons-png.flaticon.com/512/3906/3906923.png',
    AppStrings.harvest:
        'https://cdn-icons-png.flaticon.com/512/2713/2713814.png',
    AppStrings.organicFarming:
        'https://cdn-icons-png.flaticon.com/512/2965/2965567.png',
    AppStrings.weatherMonitoring:
        'https://cdn-icons-png.flaticon.com/512/2731/2731357.png',
    AppStrings.droneSurveillance:
        'https://cdn-icons-png.flaticon.com/512/4090/4090820.png',
    AppStrings.farmLabor:
        'https://cdn-icons-png.flaticon.com/512/1046/1046857.png',
    AppStrings.supplyChain:
        'https://cdn-icons-png.flaticon.com/512/3158/3158921.png',
    AppStrings.marketPrices:
        'https://cdn-icons-png.flaticon.com/512/991/991978.png',
    AppStrings.agriConsultancy:
        'https://cdn-icons-png.flaticon.com/512/3898/3898085.png',
  };

  late final List<CategoryModel> _categoryList;

  MockCategoryRepository() {
    _categoryList =
        categoryIconMap.entries.map((entry) {
          return CategoryModel(
            id: entry.key.hashCode,
            name: entry.key,
            imageUrl: entry.value,
          );
        }).toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories({required int page}) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    final start = page * _pageSize;
    if (start >= _categoryList.length) return [];

    final end = (start + _pageSize).clamp(0, _categoryList.length);
    //return _categoryList.sublist(start, end);
    //For testing
    return [];
  }
}
