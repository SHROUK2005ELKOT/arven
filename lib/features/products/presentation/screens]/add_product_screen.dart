import 'package:arven/core/widgets/custom_appbar.dart';
import 'package:arven/core/widgets/shared_button.dart'; 
import 'package:arven/core/widgets/shared_text_field.dart'; 
import 'package:flutter/material.dart';
class AddProductScreen extends StatefulWidget {
   const AddProductScreen({super.key});
@override 
State<AddProductScreen> createState() => _AddProductScreenState(); }
class _AddProductScreenState extends State<AddProductScreen> { 

  final _formKey = GlobalKey<FormState>();
final _sellerIdController = TextEditingController();
final _nameController = TextEditingController(); 
final _descriptionController = TextEditingController(); 
final _arabicNameController = TextEditingController(); 
final _arabicDescriptionController = TextEditingController(); 
final _coverPictureUrlController = TextEditingController(); 
final _priceController = TextEditingController(); 
final _stockController = TextEditingController(); 
final _weightController = TextEditingController(); 
final _colorController = TextEditingController(); 
final _discountController = TextEditingController(); 
final _categoryIdsController = TextEditingController(); 
final _productPicturesController = TextEditingController();
@override
 void dispose() {
   _sellerIdController.dispose();
   _nameController.dispose(); 
   _descriptionController.dispose(); 
   _arabicNameController.dispose(); 
   _arabicDescriptionController.dispose(); 
   _coverPictureUrlController.dispose(); 
   _priceController.dispose(); 
   _stockController.dispose(); 
   _weightController.dispose();
   _colorController.dispose(); 
   _discountController.dispose(); 
   _categoryIdsController.dispose();
   _productPicturesController.dispose();
    super.dispose(); }

 String? _requiredValidator(String? value) {
   if (value == null || value.trim().isEmpty) { 
    return 'This field is required'; } 
    return null; }

void _submitForm() { if
 (!_formKey.currentState!.validate()
 ) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('All fields are valid!'),
  ),
);
}
@override Widget build(BuildContext context) { return SafeArea( child: Scaffold( appBar: CustomAppBar(), body: Form( key: _formKey, child: ListView( padding: const EdgeInsets.all(8), children: [ const SizedBox(height: 15),
          const Center(
            child: Text(
              'ADD NEW PRODUCT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SharedTextField(
            textFieldName: 'Seller ID',
            hintTextField: 'Enter seller ID',
            controller: _sellerIdController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Product Name',
            hintTextField: 'Enter product name',
            controller: _nameController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Description',
            hintTextField: 'Enter product description',
            controller: _descriptionController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Arabic Name',
            hintTextField: 'Enter Arabic product name',
            controller: _arabicNameController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Arabic Description',
            hintTextField: 'Enter Arabic description',
            controller: _arabicDescriptionController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Cover Picture URL',
            hintTextField: 'Paste cover image URL',
            controller: _coverPictureUrlController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Price',
            hintTextField: 'Enter price',
            controller: _priceController,
            validator: _requiredValidator,
          ),SharedTextField(
            textFieldName: 'Stock',
            hintTextField: 'Enter available quantity',
            controller: _stockController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Weight',
            hintTextField: 'Enter weight',
            controller: _weightController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Color',
            hintTextField: 'Enter product color',
            controller: _colorController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Discount Percentage',
            hintTextField: 'Enter discount percentage',
            controller: _discountController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Category IDs',
            hintTextField: 'Enter category IDs separated by commas',
            controller: _categoryIdsController,
            validator: _requiredValidator,
          ),

          SharedTextField(
            textFieldName: 'Product Picture URLs',
            hintTextField: 'Enter image URLs separated by commas',
            controller: _productPicturesController,
            validator: _requiredValidator,
          ),

          const SizedBox(height: 15),

          SharedButton(
            buttonName: 'ADD PRODUCT',
            onPressed: _submitForm,
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  ),
);
} }