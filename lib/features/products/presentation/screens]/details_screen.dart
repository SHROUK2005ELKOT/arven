import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/core/widgets/custom_appbar.dart';
import 'package:arven/core/widgets/quantity_selector.dart';
import 'package:arven/core/widgets/shared_button.dart';
import 'package:arven/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel product;

  const DetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  product.coverPictureUrl,
                  height: 280,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 280,
                      child: Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'PRODUCT DETAILS',
                style: AppTextStyles.text14Regular.copyWith(
                  color: AppColors.textsecondary,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                product.name,
                style: AppTextStyles.text24Medium.copyWith(
                  color: AppColors.textprimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${product.price}',
                style: AppTextStyles.text20Regular.copyWith(
                  color: AppColors.textprimary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'DESCRIPTION',
                style: AppTextStyles.text20Medium.copyWith(
                  color: AppColors.textprimary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                product.description.isEmpty
                    ? 'No description available.'
                    : product.description,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'QUANTITY',
                    style: AppTextStyles.text16Medium,
                  ),
                  const Spacer(),
                  QuantitySelector(),
                ],
              ),
              const SizedBox(height: 15),
              SharedButton(
                buttonName: 'ADD TO CART',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}