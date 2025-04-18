import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/category_model.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_loader.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.lightGreen200,
            child: CachedNetworkImage(
              imageUrl: category.imageUrl,
              height: 40,
              width: 40,
              placeholder:
                  (context, url) =>
                      AppLoader(),
              errorWidget:
                  (context, url, error) => Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
