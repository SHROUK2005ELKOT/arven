
import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 7),
      child: AppBar(
        centerTitle: true,
        leading: showBackButton
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              )
            : const Icon(Icons.menu),
        actions: const [
          Icon(Icons.shopping_bag_outlined),
        ],
        title: Text(
          'ARVEN',
          style: AppTextStyles.text32Medium.copyWith(
            color: AppColors.textprimary,
          ),
        ),
      ),
    );
  }
}
