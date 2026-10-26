import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/features/products/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              category.coverPictureUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text20Medium.copyWith(
                      color: AppColors.textfield,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text14Regular.copyWith(
                      color: AppColors.textfield,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}