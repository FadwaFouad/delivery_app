import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants.dart';
import '../../../data/models/order.dart';
import '../../../data/services/payment_service.dart';
import '../../../providers/order_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../../size_config.dart';
import 'default_button.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  bool _isPaymentLoading = false;
  bool _isCheckoutLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  //method
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.receipt,
                    color: kPrimaryColor.shade700,
                  )),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  height: getProportionateScreenHeight(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    color: Colors.blue.shade100,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) => CartWidget(
                      cartBuilder: (controller) => InkWell(
                        // make payment button diable when checkout loading
                        onTap: _isCheckoutLoading
                            ? null
                            : () async {
                                // check if total equal Zero
                                if (controller.getTotalPrice() == 0.0)
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("nothing to  paid")));
                                else {
                                  setState(() {
                                    _isPaymentLoading = true;
                                  });
                                  // call payment service which use stripe for payment
                                  PaymentStatus paidStatus =
                                      await paymentProvider.makePayment(
                                          controller.getTotalPrice());

                                  if (paidStatus == PaymentStatus.success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("paid successfully")));
                                    // access order provider
                                    var provider = ref.read(orderProvider);
                                    // init new order
                                    Order order = Order(
                                        number: provider.getNumOfOrder,
                                        dateTime: DateTime.now(),
                                        items: controller.cartList,
                                        status: 0,
                                        paymentType: 'Paid',
                                        totalPrice: controller.getTotalPrice());
                                    // add new order to list
                                    await provider.addOrder(order);
                                    // clear cart from items
                                    controller.clearCart();
                                    setState(() {
                                      _isPaymentLoading = false;
                                    });
                                    // remove any previous snackbar
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    // show message to user
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("new order added")));
                                  } else {
                                    setState(() {
                                      _isPaymentLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("paid failed")));
                                  }
                                }
                              },
                        child: _isPaymentLoading
                            ? SizedBox(
                                width: 200,
                                height: 50,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 2.0,
                                )))
                            : Row(
                                children: [
                                  Text("Check with Credit Card ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade800)),
                                  Image.asset(
                                    'assets/images/credit.png',
                                    width: 35,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  Icon(
                                    color: Colors.blue,
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Consumer(
              builder: (context, ref, child) => CartWidget(
                cartBuilder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total\n",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: "\$${controller.getTotalPrice()}",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: _isCheckoutLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: kPrimaryColor,
                              strokeWidth: 2.0,
                            ))
                          : DefaultButton(
                              text: "Check Out",
                              // make checkout button diable when payment loading
                              press: _isPaymentLoading
                                  ? null
                                  : () async {
                                      if (controller.getTotalPrice() == 0.0)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("nothing to  paid")));
                                      else {
                                        setState(() {
                                          _isCheckoutLoading = true;
                                        });
                                        // access order provider
                                        var provider = ref.read(orderProvider);
                                        // init new order
                                        Order order = Order(
                                            number: provider.getNumOfOrder,
                                            dateTime: DateTime.now(),
                                            items: controller.cartList,
                                            status: 0,
                                            paymentType: 'Cash',
                                            totalPrice:
                                                controller.getTotalPrice());
                                        // add new order to list
                                        await provider.addOrder(order);
                                        // clear cart from items
                                        controller.clearCart();
                                        setState(() {
                                          _isCheckoutLoading = false;
                                        });
                                        // remove any previous snackbar
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                        // show message to user
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("new order added")));
                                      }
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
