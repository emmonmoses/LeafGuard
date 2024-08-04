// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/customerBalance/customer.dart';
import 'package:leafguard/models/customerBalance/customer_balance_update.dart';
import 'package:leafguard/services/balance/balanceFactory.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';

// Package Imports
import 'package:provider/provider.dart';
// ignore: avoid_web_libraries_in_flutter

class EditCustomerBalance extends StatefulWidget {
  final String balanceId;

  const EditCustomerBalance({
    super.key,
    required this.balanceId,
  });

  @override
  State<EditCustomerBalance> createState() => _EditCustomerBalanceState();
}

class _EditCustomerBalanceState extends State<EditCustomerBalance> {
  late GlobalKey<FormState> _formKeyUpdateCustomerBalance;

  final _agentIdController = TextEditingController();
  final _agentController = TextEditingController();
  final _agentNoController = TextEditingController();
  final _agentPhoneController = TextEditingController();
  final _agentBalanceController = TextEditingController();

  late GlobalKey<FormState> _formKeyEditCustomerBalance;

  CustomerBalance balanceObject = CustomerBalance();
  SharedPref sharedPref = SharedPref();
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();

    _formKeyEditCustomerBalance = GlobalKey();
  }

  @override
  Future<void> didChangeDependencies() async {
    balanceObject = await Provider.of<BalanceFactory>(context, listen: false)
        .getCustomerBalanceId(widget.balanceId);

    _agentIdController.text = balanceObject.customerId!;
    _agentController.text = balanceObject.customer!.name!;
    _agentNoController.text = balanceObject.customer!.customerNumber!;
    _agentPhoneController.text =
        balanceObject.customer!.phone!.number.toString();
    _agentBalanceController.text = balanceObject.customerBalance!.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: Provider.of<custom.MenuController>(context, listen: false)
          .scaffoldKey,
      backgroundColor: AppTheme.bgSideMenu,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppResponsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(20)),
                child: _buildForm,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppResponsive.isMobile(context)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'cancelFab',
                  onPressed: () {
                    RouteService.providersBalance(context);
                  },
                  backgroundColor: AppTheme.red,
                  mini: true,
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: AppTheme.fabSizeBoxSpace),
                FloatingActionButton(
                  heroTag: 'saveFab',
                  onPressed: () {
                    save(context);
                  },
                  backgroundColor: AppTheme.main,
                  child: const Icon(Icons.save),
                ),
              ],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget get _buildForm {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyEditCustomerBalance,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            updateHeader,
            Divider(
              thickness: AppTheme.dividerThickness,
              color: AppTheme.main,
            ),
            Visibility(
              visible: getProperty.isVisible,
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            bottom: 25.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              color: AppTheme.defaultTextColor,
                            ),
                            keyboardType: TextInputType.text,
                            controller: _agentController,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Customer cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Customer*',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              color: AppTheme.defaultTextColor,
                            ),
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            controller: _agentNoController,
                            decoration: InputDecoration(
                              labelText: 'Customer Number',
                              hintStyle: TextStyle(
                                color: AppTheme.grey,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              color: AppTheme.defaultTextColor,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _agentPhoneController,
                            decoration: InputDecoration(
                              labelText: 'Customer Phone',
                              hintStyle: TextStyle(
                                color: AppTheme.grey,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              color: AppTheme.defaultTextColor,
                            ),
                            keyboardType: TextInputType.text,
                            controller: _agentBalanceController,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              hintStyle: TextStyle(
                                color: AppTheme.grey,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: getProperty.isInvisible,
              child: Opacity(
                opacity: getProperty.isLoading ? 1.0 : 0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.main,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get updateHeader {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(
                Icons.menu,
              ),
              onPressed:
                  Provider.of<custom.MenuController>(context, listen: false)
                      .controlMenu,
            ),
          InkWell(
            onTap: () {
              // RouteService.agents(context);
            },
            child: Text(
              "Recharge Wallet",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      RouteService.customersBalance(context);
                    },
                    child: navigationIcon(
                      icon: Icons.cancel,
                      title: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.main,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => save(context),
                    child: navigationIcon(
                      icon: Icons.save,
                      title: Text(
                        'Save',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.main,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          }
        ],
      ),
    );
  }

  Widget navigationIcon({icon, title}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
          ),
        ),
        Container(
          child: title,
        )
      ],
    );
  }

  save(ctx) async {
    if (_formKeyEditCustomerBalance.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      CustomerBalanceUpdate balanceObject = CustomerBalanceUpdate(
        id: widget.balanceId,
        customerNumber: _agentNoController.text,
        customerPhone: _agentPhoneController.text,
        customerBalance: _agentBalanceController.text,
      );

      await Provider.of<BalanceFactory>(context, listen: false)
          .rechargeBalanceCustomer(balanceObject)
          .then((value) => callSuccess(ctx))
          .catchError((onError) => snackBarError(ctx, onError));
    } else {
      snackBarNotification(ctx, _formKeyUpdateCustomerBalance);
    }
  }

  callSuccess(ctx) {
    setState(() {
      getProperty.isLoading = false;
    });
    snackBarNotification(ctx, ToasterService.successMsg);
    RouteService.customersBalance(context);
  }
}
