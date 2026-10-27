
import 'package:arven/features/products/data/data_source/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final description = TextEditingController();
  final arabicName = TextEditingController();
  final arabicDescription = TextEditingController();
  final productCode = TextEditingController();
  final color = TextEditingController();
  final imageUrl = TextEditingController();
  final price = TextEditingController();
  final stock = TextEditingController();
  final weight = TextEditingController();

  final source = ProductsRemoteDataSource(Dio());
  bool loading = false;
  String category = 'charms';

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await source.addProduct({
        'sellerId': 'd051dbf3-f5d8-410d-0e50-08de06562562',
        'name': name.text.trim(),
        'description': description.text.trim(),
        'arabicName': arabicName.text.trim(),
        'arabicDescription': arabicDescription.text.trim(),
        'productCode': productCode.text.trim(),
        'color': color.text.trim(),
        'coverPictureUrl': imageUrl.text.trim(),
        'productPictures': null,
        'price': double.parse(price.text),
        'stock': int.parse(stock.text),
        'weight': double.parse(weight.text),
        'discountPercentage': 0,
        'categories': [category],
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
      Navigator.pop(context, true);
    } on DioException catch (e) {
      debugPrint('ADD PRODUCT ERROR: ${e.response?.data}');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed: ${e.response?.statusCode} - ${e.response?.data}'),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    arabicName.dispose();
    arabicDescription.dispose();
    productCode.dispose();
    color.dispose();
    imageUrl.dispose();
    price.dispose();
    stock.dispose();
    weight.dispose();
    super.dispose();
  }

  Widget field(String label, TextEditingController controller,
      {bool numeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            field('Product name', name),
            field('Description', description),
            field('Arabic name', arabicName),
            field('Arabic description', arabicDescription),
            field('Product code', productCode),
            field('Color', color),
            field('Cover image URL', imageUrl),
            field('Price', price, numeric: true),
            field('Stock', stock, numeric: true),
            field('Weight', weight, numeric: true),
            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: [
                'charms',
                'clothes',
                'glasses',
                'jewelry',
                'bags',
                'sneakers',
                'watches',
              ].map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  )).toList(),
              onChanged: (value) {
                if (value != null) setState(() => category = value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : submit,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
