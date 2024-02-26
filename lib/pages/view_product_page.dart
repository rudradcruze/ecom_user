import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewProduct';
  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Product'),),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.productList.length,
          itemBuilder: (context, index) {
            print(provider.productList.length);
            final product = provider.productList[index];
            return ListTile(
              title: Text(product.productName),
              subtitle: Text('Current stock: ${product.stock}'),
            );
          },
        )
      ),
    );
  }
}
