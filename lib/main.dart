import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:payment/payment_configuration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Pay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items = [
    PaymentItem(label: "car", amount: "100", type: PaymentItemType.item),
    PaymentItem(label: "moto", amount: "5", type: PaymentItemType.item),
  ];

  onPaymentResult(result) {
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 70,
              child: Platform.isAndroid
                  ? GooglePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                      onPaymentResult: onPaymentResult, paymentItems: items)
                  : ApplePayButton(
                paymentConfiguration:  PaymentConfiguration.fromJsonString(defaultApplePay),
                      onPaymentResult: onPaymentResult, paymentItems: items)),
        ),
      ),
    );
  }
}
