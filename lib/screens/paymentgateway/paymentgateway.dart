// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/widgets/paymentgateway/paymentgateway_header.dart';
import 'package:leafguard/widgets/paymentgateway/paymentgateway_table.dart';

class PaymentGatewayIndex extends StatefulWidget {
  const PaymentGatewayIndex({super.key});

  @override
  State<PaymentGatewayIndex> createState() => _PaymentGatewayIndexState();
}

class _PaymentGatewayIndexState extends State<PaymentGatewayIndex> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.bgWhiteMixin,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          const PaymentGatewayHeader(),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          const PaymentGatewayTable(),
        ],
      ),
    );
  }
}
