import 'package:arven/core/theme/app_colors.dart';

import 'package:arven/core/theme/text_style.dart';

import 'package:arven/features/products/data/models/product_model.dart';
import 'package:arven/features/products/presentation/cubit/home_cubit.dart';
import 'package:arven/features/products/presentation/cubit/home_state.dart';

import 'package:arven/features/products/presentation/screens%5D/details_screen.dart';



import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCard extends StatelessWidget {

  final ProductModel product;

  const HomeCard({

    super.key,

    required this.product,

  });

  Future<void> _confirmDelete(BuildContext context) async {

    final shouldDelete = await showDialog<bool>(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          title: const Text('Delete Product'),

          content: Text(

            'Are you sure you want to delete ${product.name}?',

          ),

          actions: [

            TextButton(

              onPressed: () => Navigator.pop(dialogContext, false),

              child: const Text('Cancel'),

            ),

            TextButton(

              onPressed: () => Navigator.pop(dialogContext, true),

              child: const Text(

                'Delete',

                style: TextStyle(color: Colors.red),

              ),

            ),

          ],

        );

      },

    );

    if (shouldDelete != true || !context.mounted) return;

    await context.read<HomeCubit>().deleteProduct(

      product.id.toString(),

    );

    if (!context.mounted) return;

    final state = context.read<HomeCubit>().state;

    if (state is HomeSuccess) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(content: Text('Product deleted successfully')),

      );

    } else if (state is HomeFailure) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text(state.message)),

      );

    }

  }

  @override

  Widget build(BuildContext context) {

    return Card(

      clipBehavior: Clip.antiAlias,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(

            child: InkWell(

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) => DetailsScreen(product: product),

                  ),

                );

              },

              child: SizedBox(

                width: double.infinity,

                child: Image.network(

                  product.coverPictureUrl,

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {

                    return const Center(

                      child: Icon(Icons.image_not_supported),

                    );

                  },

                ),

              ),

            ),

          ),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 8),

            child: Text(

              product.name,

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: AppTextStyles.text14Regular.copyWith(

                color: AppColors.textprimary,

              ),

            ),

          ),

          Padding(

            padding: const EdgeInsets.only(left: 8, right: 4, bottom: 4),

            child: Row(

              children: [

                Expanded(

                  child: Text(

                    '\$${product.price}',

                    style: AppTextStyles.text14Regular.copyWith(

                      color: AppColors.textprimary,

                    ),

                  ),

                ),

                IconButton(

                  onPressed: () => _confirmDelete(context),

                  icon: const Icon(

                    Icons.delete_outline,

                    color: Colors.red,

                  ),

                  tooltip: 'Delete product',

                ),

              ],

            ),),

        ],

      ),

    );

  }

}