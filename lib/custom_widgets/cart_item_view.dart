import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    super.key,
    required this.cartModel,
    required this.priceWithQuantity, required this.onIncrease, required this.onDecrease, required this.onDelete,
  });

  final CartModel cartModel;
  final num priceWithQuantity;
  final Function(CartModel cartModel) onIncrease;
  final Function(CartModel cartModel) onDecrease;
  final Function(String pid) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(
                imageUrl: cartModel.imageUrl,
                placeholder: (context, url) =>
                    Image.asset('assets/images/image-not-available.png'),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(cartModel.productName),
              subtitle: Text('Unit Price: $currencySymbol${cartModel.price.toStringAsFixed(1)}'),
              trailing: Text(
                '$currencySymbol$priceWithQuantity',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    onDecrease(cartModel);
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
                Text(
                  '${cartModel.quantity}',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    onIncrease(cartModel);
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    onDelete(cartModel.productId);
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
