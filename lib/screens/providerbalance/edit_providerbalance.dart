// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
import 'package:leafguard/models/providerBalance/provider_balance_update.dart';
import 'package:leafguard/services/balance/balanceFactory.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';

// Package Imports
import 'package:provider/provider.dart';
// ignore: avoid_web_libraries_in_flutter

class EditProviderBalance extends StatefulWidget {
  final String balanceId;

  const EditProviderBalance({
    super.key,
    required this.balanceId,
  });

  @override
  State<EditProviderBalance> createState() => _EditProviderBalanceState();
}

class _EditProviderBalanceState extends State<EditProviderBalance> {
  late GlobalKey<FormState> _formKeyUpdateProviderBalance;

  final _agentIdController = TextEditingController();
  final _agentController = TextEditingController();
  final _agentNoController = TextEditingController();
  final _agentPhoneController = TextEditingController();
  final _agentBalanceController = TextEditingController();

  late GlobalKey<FormState> _formKeyEditProviderBalance;

  ProviderBalance balanceObject = ProviderBalance();
  SharedPref sharedPref = SharedPref();
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();

    _formKeyEditProviderBalance = GlobalKey();
  }

  @override
  Future<void> didChangeDependencies() async {
    balanceObject = await Provider.of<BalanceFactory>(context, listen: false)
        .getTaskerBalanceId(widget.balanceId);

    _agentIdController.text = balanceObject.taskerId!;
    _agentController.text = balanceObject.tasker!.name!;
    _agentNoController.text = balanceObject.tasker!.taskerNumber!;
    _agentPhoneController.text = balanceObject.tasker!.phone!.number.toString();
    _agentBalanceController.text = balanceObject.taskerBalance!.toString();
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
        key: _formKeyEditProviderBalance,
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
                padding: EdgeInsets.only(
                  left: 15.0,
                  bottom: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
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
                                return 'Provider cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Provider*',
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
                              labelText: 'Provider Number',
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
                              labelText: 'Provider Phone',
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
                      RouteService.providersBalance(context);
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
    if (_formKeyEditProviderBalance.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      ProviderBalanceUpdate balanceObject = ProviderBalanceUpdate(
        id: widget.balanceId,
        taskerNumber: _agentNoController.text,
        taskerPhone: _agentPhoneController.text,
        taskerBalance: _agentBalanceController.text,
      );

      await Provider.of<BalanceFactory>(context, listen: false)
          .rechargeBalanceTasker(balanceObject)
          .then((value) => callSuccess(ctx))
          .catchError((onError) => snackBarError(ctx, onError));
    } else {
      snackBarNotification(ctx, _formKeyUpdateProviderBalance);
    }
  }

  callSuccess(ctx) {
    setState(() {
      getProperty.isLoading = false;
    });
    snackBarNotification(ctx, ToasterService.successMsg);
    RouteService.providersBalance(context);
  }
}
