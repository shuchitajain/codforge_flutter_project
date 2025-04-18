import '../../core/widgets/app_loader.dart';
import '../../core/widgets/common_buttons.dart';
import '../../core/constants/colors.dart' show AppColors;
import '../../core/constants/strings.dart';
import '../../core/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/info_state_widget.dart';
import 'category_controller.dart';
import 'widgets/category_tile.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    // It triggers only once when the widget first mounts to prevent fetch on widget rebuild
    Future.microtask(() {
      ref.read(categoryControllerProvider.notifier).loadInitialCategories();
    });

    _scrollController.addListener(() {
      final notifier = ref.read(categoryControllerProvider.notifier);
      final state = ref.read(categoryControllerProvider);

      final isBottom =
          _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100;

      if (_isAtBottom != isBottom) {
        setState(() {
          _isAtBottom = isBottom;
        });
      }

      debugPrint(
        "Pixels: ${_scrollController.position.pixels}, Max: ${_scrollController.position.maxScrollExtent - 200}",
      );

      // Load more categories when scrolled to the bottom
      // and if there are more categories to load
      // and if there is no ongoing loading
      // and if the user is not already at the bottom
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isAtBottom &&
          !state.isLoading &&
          state.hasMore) {
        _isAtBottom = true; // avoid duplicate calls
        notifier.loadMoreCategories().then((_) {
          final updated = ref.read(categoryControllerProvider);
          if (mounted &&
              updated.error != null &&
              updated.categories.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(updated.error!)));
          }
        });
      } else if (_scrollController.position.pixels <
          _scrollController.position.maxScrollExtent - 200) {
        _isAtBottom = false; // allow re-trigger
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: CommonAppbar(
        title: AppStrings.category,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined, size: 30),
                onPressed: () {
                  ref
                      .read(categoryControllerProvider.notifier)
                      .loadInitialCategories();
                },
              ),
              Positioned(
                top: 13,
                right: 13,
                child: CircleAvatar(backgroundColor: AppColors.red, radius: 5),
              ),
            ],
          ),
        ],
      ),
      body:
          // Loading and categories are empty
          (state.isLoading && state.categories.isEmpty)
              ? const Center(child: AppLoader())
              // Error occurred and categories are empty
              : (state.error != null && state.categories.isEmpty)
              ? InfoStateWidget(
                message: state.error!,
                action: CommonButtons.retryButton(
                  onPressed: () {
                    ref
                        .read(categoryControllerProvider.notifier)
                        .loadInitialCategories();
                  },
                ),
              )
              // Loading complete and categories are empty
              : state.categories.isEmpty
              ? InfoStateWidget(
                message: AppStrings.noCategoriesAvailablle,
                action: CommonButtons.retryButton(
                  onPressed: () {
                    ref
                        .read(categoryControllerProvider.notifier)
                        .loadInitialCategories();
                  },
                ),
              )
              // Loading complete and categories are not empty
              : RefreshIndicator(
                color: AppColors.green,
                onRefresh: () async {
                  ref.invalidate(categoryControllerProvider);
                  await ref
                      .read(categoryControllerProvider.notifier)
                      .loadInitialCategories();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(20),
                        itemCount: state.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            category: state.categories[index],
                          );
                        },
                      ),
                    ),
                    if (_isAtBottom) ...[
                      if (state.isLoading && state.hasMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: AppLoader(),
                        )
                      else if (!state.isLoading && !state.hasMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(AppStrings.endOfCategories),
                        ),
                    ] else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
