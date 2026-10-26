import 'package:arven/core/widgets/custom_appbar.dart';
import 'package:arven/features/products/data/data_source/category_remote_data_source.dart'; 
import 'package:arven/features/products/presentation/cubit/category_cubit.dart'; 
import 'package:arven/features/products/presentation/cubit/category_state.dart'; 
import 'package:arven/features/products/presentation/widgets/category_card.dart'; 
import 'package:arven/features/products/presentation/widgets/category_list_card.dart'; 
import 'package:dio/dio.dart'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget { 
  const CategoryScreen({
    super.key});
@override Widget build(BuildContext context) { 
  return BlocProvider( create: (_) => CategoryCubit(
     CategoriesRemoteDataSource(Dio()), )..getCategories(), 
     child: const CategoryView(), ); } }
class CategoryView extends StatelessWidget { 
  const CategoryView({super.key});
@override Widget build(BuildContext context) {
   return SafeArea( child: Scaffold( 
    appBar: CustomAppBar(),
     body: BlocBuilder<CategoryCubit, CategoryState>( builder: (context, state) { 
      if (state is CategoryInitial || state is CategoryLoading) {

         return const Center( child: CircularProgressIndicator(), ); }
        if (state is CategoryFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load categories'),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CategoryCubit>().getCategories();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CategorySuccess) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return const Center(
              child: Text('No categories available'),
            );
          }

          return ListView(
            children: [
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryListCard(
                      title: categories[index].name,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: categories[index],
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    ),
  ),
);
} }