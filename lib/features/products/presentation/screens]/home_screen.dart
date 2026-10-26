import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/core/widgets/custom_appbar.dart';
import 'package:arven/features/products/data/data_source/remote_data_source.dart';
import 'package:arven/features/products/presentation/cubit/home_cubit.dart';
import 'package:arven/features/products/presentation/cubit/home_state.dart';
import 'package:arven/features/products/presentation/widgets/home_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        ProductsRemoteDataSource(Dio()),
      )..getProducts(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              height: 400,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/stackimage.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LIMITED EDITION',
                          style: AppTextStyles.text16Medium.copyWith(
                            color: AppColors.background,
                          ),
                        ),
                        Text(
                          'The Onyx Chrono',
                          style: AppTextStyles.text32Medium.copyWith(
                            color: AppColors.background,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'DISCOVER MORE',
                            style: AppTextStyles.text16Medium.copyWith(
                              color: AppColors.textprimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Products',
                  style: AppTextStyles.text20Medium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Curated architectural silhouettes for the modern\nwardrobe.',
                  style: AppTextStyles.text14Regular.copyWith(
                    color: AppColors.textsecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial || state is HomeLoading) {
                return const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is HomeFailure) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [const Text('Failed to load products'),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HomeCubit>().getProducts();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is HomeSuccess) {
                final products = state.products;

                if (products.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('No products available'),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return HomeCard(product: products[index]);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}