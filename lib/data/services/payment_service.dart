import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../keys.dart';

enum PaymentStatus { success, fail }

// define currency
const String _currency = 'USD';

class PaymentService {
  Map<String, dynamic>? paymentIntent;

  Future<PaymentStatus> makePayment(
    double amount,
  ) async {
    PaymentStatus status = PaymentStatus.fail;
    try {
      // change amount to integer and to string after that
      paymentIntent = await createPaymentIntent(amount, _currency);
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Fadwa'))
          .then((value) {});

      ///now finally display payment sheeet
      status = await displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
    return status;
  }

  Future<PaymentStatus> displayPaymentSheet() async {
    PaymentStatus status = PaymentStatus.fail;
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        status = PaymentStatus.success;
        paymentIntent = null;
      }).onError((error, stackTrace) {
        status = PaymentStatus.fail;
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      status = PaymentStatus.fail;
      print('Error is:---> $e');
    } catch (e) {
      status = PaymentStatus.fail;
      print('$e');
    }
    return status;
  }

// send request to stripe to get [client_secret]
  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secret_key',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

// cal amount from string to cenets
  calculateAmount(double amount) {
    //cal amount Int Cents to use with stripe API
    int amountInCents = (amount * 100).toInt();
    return amountInCents.toString();
  }
}
