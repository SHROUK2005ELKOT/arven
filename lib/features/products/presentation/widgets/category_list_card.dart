import 'package:arven/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryListCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryListCard({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? AppColors.textprimary
                : AppColors.lightGray,
          ),
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(7),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? AppColors.background
                  : AppColors.textprimary,
            ),
          ),
        ),
      ),
    );
  }
}