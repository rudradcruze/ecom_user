import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: ListView(
        children: [
          buildItemSection(),
          buildOrderSummerySection(),
        ],
      ),
    );
  }

  Widget buildItemSection() {
    return Card(
          child: Consumer<CartProvider>(
            builder: (context, provider, child) => Column(
              children: [
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 20.0),
                ),
                const Divider(
                  color: Colors.black,
                  height: 2.0,
                ),
                for (final cart in provider.cartList)
                  ListTile(
                    title: Text(cart.productName),
                    trailing: Text(
                      '${cart.quantity}x${cart.price}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
  }

  Widget buildOrderSummerySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Order Summery',
              style: TextStyle(fontSize: 20.0),
            ),
            const Divider(
              color: Colors.black,
              height: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal', style: TextStyle(fontSize: 16.0),),
                  const Text('$currencySymbol 323432', style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Charge', style: TextStyle(fontSize: 16.0),),
                  const Text('$currencySymbol 100', style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Discount(0%)', style: TextStyle(fontSize: 16.0),),
                  const Text('-$currencySymbol 0', style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('VAT(0%)', style: TextStyle(fontSize: 16.0),),
                  const Text('-$currencySymbol 560', style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grand Total', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  const Text('$currencySymbol 56430', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
