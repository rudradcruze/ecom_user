import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getOrderConstant();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: ListView(
        children: [
          buildItemSection(),
          buildOrderSummerySection(context, Provider.of<CartProvider>(context, listen: false).getCartSubTotal),
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

  Widget buildOrderSummerySection(context, num subtotal) {
    var provider = Provider.of<OrderProvider>(context);
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
                  Text('$currencySymbol$subtotal', style: const TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Charge', style: TextStyle(fontSize: 16.0),),
                  Text('$currencySymbol${provider.orderConstantModel.deliveryCharge}', style: const TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount(${provider.orderConstantModel.discount}%)', style: const TextStyle(fontSize: 16.0),),
                  Text('-$currencySymbol${provider.getDiscountAmount(subtotal)}', style: const TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('VAT(${provider.orderConstantModel.vat}%)', style: const TextStyle(fontSize: 16.0),),
                  Text('+$currencySymbol${provider.getVatAmount(subtotal)}', style: const TextStyle(fontSize: 16.0),),
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
                  Text('$currencySymbol${provider.getGrantTotal(subtotal)}', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
