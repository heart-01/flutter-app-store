import 'package:flutter/material.dart';
import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/screens/products/components/product_item.dart';
import 'package:flutter_store/services/rest_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLayoutGridView = false;

  void handleOnClickChangeLayoutView() {
    setState(() {
      isLayoutGridView = !isLayoutGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: handleOnClickChangeLayoutView,
          icon: Icon(isLayoutGridView ? Icons.list_outlined : Icons.grid_view),
        ),
        title: const Text('สินค้า'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CallAPI().getAllProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            // Error
            return const Center(
              child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            // Success
            List<ProductModel> products = snapshot.data;
            return isLayoutGridView
                ? layoutGridView(products)
                : layoutListView(products);
          } else {
            // Pending
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // layout gridView Widget
  Widget layoutGridView(List<ProductModel> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of column
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        mainAxisExtent: 200,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(
          isLayoutGridView: true,
          product: products[index],
          handleOnClickProduct: () {},
        );
      },
    );
  }

  // layout listView Widget
  Widget layoutListView(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
          child: SizedBox(
            height: 350,
            child: ProductItem(
              product: products[index],
              handleOnClickProduct: () {},
            ),
          ),
        );
      },
    );
  }
}
