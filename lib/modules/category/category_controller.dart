import 'package:flutter/material.dart';
import '../../core/constants/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/category_model.dart';
import '../../repository/api_category_repository.dart';
import '../../repository/category_repository.dart';

class CategoryState {
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final List<CategoryModel> categories;
  final int page;

  const CategoryState({
    this.isLoading = false,
    this.error,
    this.hasMore = true,
    this.categories = const [],
    this.page = 0,
  });

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    bool? hasMore,
    List<CategoryModel>? categories,
    int? page,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      categories: categories ?? this.categories,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'CategoryState(isLoading: $isLoading, error: $error, hasMore: $hasMore, categories: $categories, page: $page)';
  }
}

// This controller manages the state of the categories
class CategoryController extends StateNotifier<CategoryState> {
  final ICategoryRepository repository;

  CategoryController(this.repository) : super(const CategoryState());

  Future<void> loadInitialCategories() async {
    // Check if categories are already loaded or if a request is in progress to prevent refetching
    if (state.categories.isNotEmpty || state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final categories = await repository.fetchCategories(page: 0);
      state = state.copyWith(
        isLoading: false,
        categories: categories,
        page: 1,
        hasMore: categories.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '${AppStrings.errorFetchingCategories}: $e',
      );
    }
  }

  Future<void> loadMoreCategories() async {
    if (!state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    debugPrint('State while loading more: ${state.toString()}');

    try {
      debugPrint('Loading more categories...');
      final result = await repository.fetchCategories(page: state.page);
      final newList = [...state.categories, ...result];
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('Loaded more categories: ${result.length}');
      state = state.copyWith(
        isLoading: false,
        categories: newList,
        page: state.page + 1,
        hasMore: result.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppStrings.errorFetchingMoreCategories,
      );
    }
  }
}

final categoryRepositoryProvider = Provider<ICategoryRepository>((ref) {
  ///TODO: Uncomment and do hot restart to test no data state
  //return MockCategoryRepository();
  return ApiCategoryRepository();
});

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, CategoryState>((ref) {
      final repo = ref.watch(categoryRepositoryProvider);
      return CategoryController(repo);
    });
