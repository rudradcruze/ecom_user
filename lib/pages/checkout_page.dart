import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/auth/auth_service.dart';
import 'package:ecom_user/custom_widgets/checkout_headline.dart';
import 'package:ecom_user/models/order_model.dart';
import 'package:ecom_user/pages/order_successful_page.dart';
import 'package:ecom_user/pages/view_product_page.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/theme/theme.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:ecom_user/utils/helper_function.dart';
import 'package:ecom_user/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildItemSection(),
                buildOrderSummerySection(
                    context,
                    Provider.of<CartProvider>(context, listen: false)
                        .getCartSubTotal),
                buildDeliveryAddressSection(addressController),
              ],
            ),
          ),
          Card(
            color: lightColorScheme.primary,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: lightColorScheme.primary,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      onPressed: () {
                        if (addressController.text.isEmpty) {
                          showMsg(context, 'Please provide a delivery address');
                          return;
                        } else {
                          _saveOrder(context, addressController.text);
                        }
                      },
                      child: const Text('Place Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemSection() {
    return Card(
      child: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            const CheckoutHeadline(
              headline: 'Items',
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
            const CheckoutHeadline(
              headline: 'Order Summery',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '$currencySymbol$subtotal',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Charge',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '$currencySymbol${provider.orderConstantModel.deliveryCharge}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount(${provider.orderConstantModel.discount}%)',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '-$currencySymbol${provider.getDiscountAmount(subtotal)}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VAT(${provider.orderConstantModel.vat}%)',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '+$currencySymbol${provider.getVatAmount(subtotal)}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
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
                  const Text(
                    'Grand Total',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$currencySymbol${provider.getGrantTotal(subtotal)}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryAddressSection(TextEditingController addressController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CheckoutHeadline(
              headline: 'Delivery Address',
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                labelText: 'Enter Delivery Address',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveOrder(BuildContext context, String address) {
    var orderProvider = context.read<OrderProvider>();
    var cartProvider = context.read<CartProvider>();
    final orderModel = OrderModel(
      orderId: generateOrderId(),
      uid: AuthService.uid,
      orderDate: Timestamp.fromDate(DateTime.now()),
      deliveryCharge: orderProvider.orderConstantModel.deliveryCharge,
      discount: orderProvider.orderConstantModel.discount,
      vat: orderProvider.orderConstantModel.vat,
      grantTotal: orderProvider.getGrantTotal(cartProvider.getCartSubTotal),
      orderStatus: OrderStatus.pending,
      orderDetails: List.generate(cartProvider.cartList.length, (index) => cartProvider.cartList[index].toJson()),
    );
    EasyLoading.show(status: 'Please Wait...');
    context.read<OrderProvider>().saveOrder(orderModel).then((value) async {
      cartProvider.clearCart();
      EasyLoading.dismiss();
      showMsg(context, '${orderModel.orderId} is successfully placed!');
      Navigator.pushNamedAndRemoveUntil(context, OrderSuccessfulPage.routeName, ModalRoute.withName(ViewProductPage.routeName));
    }).catchError((error) {
      EasyLoading.dismiss();
      showMsg(context, 'Something went wrong! Failed to place order');
    });
  }
}
