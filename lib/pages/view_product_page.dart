import 'package:ecom_user/auth/auth_service.dart';
import 'package:ecom_user/pages/cart_page.dart';
import 'package:ecom_user/pages/launcher_page.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/custom_widgets/product_item_view.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewProduct';

  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<CartProvider>(context, listen: false).getAllCartItem();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstant();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 250.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          itemCount: provider.productList.length,
          itemBuilder: (context, index) {
            final product = provider.productList[index];
            return ProductItemView(product: product);
          },
        ),
      ),
    );
  }
}
