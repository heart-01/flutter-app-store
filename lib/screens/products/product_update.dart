import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_store/components/image_not_found.dart';
import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_store/screens/products/components/product_form.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:flutter_store/utils/constants.dart';
import 'package:flutter_store/utils/utility.dart';

class ProductUpdate extends StatefulWidget {
  const ProductUpdate({super.key});

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  final _formKeyUpdateProduct = GlobalKey<FormState>();
  final product = ProductModel(
    id: 0,
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
    // Get arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Set initial value from Model
    product.id = arguments['products']['id'];
    product.name = arguments['products']['name'];
    product.description = arguments['products']['description'];
    product.barcode = arguments['products']['barcode'];
    product.stock = arguments['products']['stock'];
    product.price = arguments['products']['price'];
    product.categoryId = arguments['products']['category_id'];
    product.userId = arguments['products']['user_id'];
    product.statusId = arguments['products']['status_id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้สินค้า'),
        actions: [
          // Save Button
          IconButton(
            onPressed: () async {
              if (_formKeyUpdateProduct.currentState!.validate()) {
                _formKeyUpdateProduct.currentState!.save();
                Utility().logger.d(product.toJson());
                Utility().logger.d(_imageFile);

                // Call API Update Product
                final response = await CallAPI()
                    .updateProductAPI(product, imageFile: _imageFile);
                final body = jsonDecode(response);

                if (body['status'] == 'ok') {
                  if (context.mounted) {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    refreshKey.currentState!.show(); // Refresh HomeScreen
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
            SizedBox(
              width: double.infinity,
              height: 300,
              child: arguments['products']['image'] != null ? impagePreview(arguments['products']['image']) : const ImageNotFound(),
            ),
            ProductForm(
              formKey: _formKeyUpdateProduct,
              product,
              handleOnChangeImage: handleOnChangeImage,
            ),
          ],
        ),
      ),
    );
  }

  // impagePreview Widget
  Container impagePreview(String image) {
    String imageUrl;
    if (image.contains('://')) {
      imageUrl = image;
    } else {
      imageUrl = '$baseURLImage$image';
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
