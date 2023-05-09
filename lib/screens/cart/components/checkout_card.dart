import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../data/services/payment_service.dart';
import '../../../providers/payment_provider.dart';
import '../../../size.config.dart';
import 'default_button.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  bool _isLoadingPayment = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
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
                  child: CartWidget(
                    cartBuilder: (controller) => InkWell(
                      onTap: () async {
                        // check if total equal Zero
                        if (controller.getTotalPrice() == 0.0)
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("nothing to  paid")));
                        else {
                          setState(() {
                            _isLoadingPayment = true;
                          });
                          // call payment service which use stripe for payment
                          PaymentStatus paidStatus = await paymentProvider
                              .makePayment(controller.getTotalPrice());
                          setState(() {
                            _isLoadingPayment = false;
                          });
                          if (paidStatus == PaymentStatus.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("paid successfully")));
                            // clear cart from item
                            controller.clearCart();
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("paid failed")));
                        }
                      },
                      child: _isLoadingPayment
                          ? SizedBox(
                              width: 200,
                              height: 50,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue)))
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
                )
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            CartWidget(
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
                    child: DefaultButton(
                      text: "Check Out",
                      press: () {
                        if (controller.getTotalPrice() == 0.0)
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("nothing to  paid")));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
