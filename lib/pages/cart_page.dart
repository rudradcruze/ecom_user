import 'package:ecom_user/custom_widgets/cart_item_view.dart';
import 'package:ecom_user/pages/view_product_page.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/theme/theme.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) =>
        !provider.isCartEmpty ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  final cart = provider.cartList[index];
                  return CartItemView(
                    cartModel: cart,
                    priceWithQuantity: provider.priceWithQuantity(cart),
                    onIncrease: (cart) {
                      provider.increaseQuantity(cart);
                    },
                    onDecrease: (cart) {
                      provider.decreaseQuantity(cart);
                    },
                    onDelete: (pid) {
                      provider.removeFromCart(pid);
                    },
                  );
                },
              ),
            ),
            Card(
              color: lightColorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal: $currencySymbol${provider.getCartSubTotal}',
                      style:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: lightColorScheme.primary,
                        side: BorderSide(color: Colors.transparent),
                      ),
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speaker_notes_off),
                  Text(' No product found in the card!'),
                ],
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, ViewProductPage.routeName),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                child: const Text('Buy Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
