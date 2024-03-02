import 'package:ecom_user/pages/view_product_page.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatelessWidget {
  static const String routeName = '/successful';
  const OrderSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your order is successfully placed!'),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, ViewProductPage.routeName),
              child: const Text('Shopping More!'),
            ),
          ],
        ),
      ),
    );
  }
}
