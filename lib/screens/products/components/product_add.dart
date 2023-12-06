import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/screens/products/components/product_form.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:flutter_store/utils/utility.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKeyAddProduct = GlobalKey<FormState>();
  final product = ProductModel(
    name: '',
    description: '',
    barcode: '',
    price: 0,
    stock: 0,
    categoryId: 1,
    userId: 1,
    statusId: 1,
  );
  File? _imageFile;

  void handleOnChangeImage(File? imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสินค้าใหม่'),
        actions: [
          // Save Button
          IconButton(
            onPressed: () async {
              if (_formKeyAddProduct.currentState!.validate()) {
                _formKeyAddProduct.currentState!.save();
                Utility().logger.d(product.toJson());
                Utility().logger.d(_imageFile);

                // Call API Add Product
                final response = await CallAPI().addProductAPI(product, imageFile: _imageFile);
                final body = jsonDecode(response);

                if (body['status'] == 'ok') {
                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                }
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductForm(
              formKey: _formKeyAddProduct,
              product,
              handleOnChangeImage: handleOnChangeImage,
            ),
          ],
        ),
      ),
    );
  }
}
