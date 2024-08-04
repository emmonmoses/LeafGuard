// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/models/billing/billing_update.dart';
import 'package:leafguard/screens/billing/home.dart';
import 'package:leafguard/services/billing/billingFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditBilling extends StatefulWidget {
  static const routeName = '/billingupdate';

  const EditBilling({super.key});

  @override
  State<EditBilling> createState() => _EditBillingState();
}

class _EditBillingState extends State<EditBilling> {
  late GlobalKey<FormState> _formKeyUpdateBilling;

  final _billingPeriodController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  int billingStatus = 0;
  int billingValue = 0;
  VariableService getProperty = VariableService();
  Billing updatedBilling = Billing();

  @override
  void initState() {
    super.initState();
    _formKeyUpdateBilling = GlobalKey();
  }

  @override
  void dispose() {
    _billingPeriodController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> selectDate(TextEditingController controller) async {
    await VariableService.selectDate(
        controller, _fromController, _toController, context);
  }

  @override
  void didChangeDependencies() {
    final billing = ModalRoute.of(context)!.settings.arguments as Billing;

    if (getProperty.isInit) {
      updatedBilling = Provider.of<BillingFactory>(context, listen: false)
          .getBillingId(billing.id);

      _billingPeriodController.text = updatedBilling.billingcycyle!;
      _fromController.text = DateFormat('yyyy-MM-dd').format(
        updatedBilling.start_date!,
      );
      _toController.text = DateFormat('yyyy-MM-dd').format(
        updatedBilling.end_date!,
      );

      billingStatus = updatedBilling.status!;
      getProperty.isActive = billingStatus == 1;
    }
    getProperty.isInit = false;

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
    );
  }

  Widget get _buildForm {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyUpdateBilling,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            updateHeader,
            Divider(
              thickness: AppTheme.dividerThickness,
              color: AppTheme.main,
            ),
            Visibility(
              visible: getProperty.isVisible,
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Mandatory fields are marked with (*)'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _billingPeriodController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name*',
                        hintText: 'e.g Yearly Discount',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _fromController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Valid from cannot be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () => selectDate(_fromController),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month_rounded),
                        labelText: 'Valid From*',
                        hintText: 'e.g 2023-08-15',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _toController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Valid to cannot be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () => selectDate(_toController),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month_rounded),
                        labelText: 'Valid To*',
                        hintText: 'e.g 2023-08-15',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text(
                      'Status',
                      style: TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                    ),
                    subtitle: billingStatus == 1
                        ? Text(
                            'Active',
                            style: TextStyle(
                              color: AppTheme.main,
                            ),
                          )
                        : Text(
                            'In Active',
                            style: TextStyle(
                              color: AppTheme.red,
                            ),
                          ),
                    activeColor: AppTheme.main,
                    inactiveThumbColor: AppTheme.defaultTextColor,
                    inactiveTrackColor: AppTheme.grey,
                    value: getProperty.isActive,
                    onChanged: (bool value) {
                      setState(() {
                        getProperty.isActive = value;
                        billingStatus = getProperty.isActive ? 1 : 0;
                      });
                    },
                  ),
                ),
              ],
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
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const BillingHome(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_left,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              RouteService.billings(context);
            },
            child: Text(
              "Edit Billing",
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
                      RouteService.billings(context);
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
    if (_formKeyUpdateBilling.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      BillingUpdate billingObject = BillingUpdate(
        id: updatedBilling.id!,
        billing_period: _billingPeriodController.text,
        valid_from: _fromController.text,
        valid_to: _toController.text,
        status: billingStatus,
      );
      await Provider.of<BillingFactory>(context, listen: false)
          .updateBilling(billingObject);
      setState(() {
        getProperty.isLoading = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
    } else {
      snackBarError(ctx, _formKeyUpdateBilling);
    }
  }
}
