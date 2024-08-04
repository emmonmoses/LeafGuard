import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/customer/customer_header.dart';
import 'package:leafguard/widgets/customer/customer_table.dart';

class CustomerIndex extends StatefulWidget {
  const CustomerIndex({Key? key}) : super(key: key);

  @override
  State<CustomerIndex> createState() => _CustomerIndexState();
}

class _CustomerIndexState extends State<CustomerIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.bgWhiteMixin,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListView(
          children: [
            const CustomerHeader(),
            Divider(
              thickness: AppTheme.dividerThickness,
              color: AppTheme.main,
            ),
            const CustomerTable(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppTheme.green,
      //   onPressed: () {
      //     showModalSideSheet(
      //       context: context,
      //       width: 550,
      //       ignoreAppBar: true,
      //       body: const ForgetPasswordScreen(),
      //     );
      //   },

      //   child: const Icon(
      //     Icons.lock,
      //     color: AppTheme.primary,
      //   ), // Use the lock icon
      // ),
    );
  }
}
