// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/gatewaySetting/gatewaysetting.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway_update.dart';
import 'package:leafguard/services/paymentgateway/paymentGatewayFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/models/search/search.dart';
import 'package:leafguard/screens/paymentgateway/home.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditPaymentGateway extends StatefulWidget {
  static const routeName = '/paymentgatewayupdate';

  const EditPaymentGateway({super.key});

  @override
  State<EditPaymentGateway> createState() => _EditPaymentGatewayState();
}

class _EditPaymentGatewayState extends State<EditPaymentGateway> {
  late GlobalKey<FormState> _formKeyUpdatePaymentGateway;
  final _gatewayController = TextEditingController();
  final _aliasController = TextEditingController();
  final _livekeyController = TextEditingController();
  final _sandboxkeyController = TextEditingController();
  final _clientkeyController = TextEditingController();
  final _modeController = TextEditingController();
  final _secretkeyController = TextEditingController();
  final _publishkeyController = TextEditingController();
  final _redirectUriController = TextEditingController();

  Constants search = Constants();
  VariableService getProperty = VariableService();
  PaymentGateway updatedGateway = PaymentGateway();

  int? userStatus;

  @override
  void initState() {
    super.initState();
    _formKeyUpdatePaymentGateway = GlobalKey();
  }

  @override
  void dispose() {
    _gatewayController.dispose();
    _aliasController.dispose();
    _livekeyController.dispose();
    _sandboxkeyController.dispose();
    _clientkeyController.dispose();
    _modeController.dispose();
    _secretkeyController.dispose();
    _publishkeyController.dispose();
    _redirectUriController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    final paymentgateway =
        ModalRoute.of(context)!.settings.arguments as PaymentGateway;

    if (getProperty.isInit) {
      updatedGateway = await Provider.of<PaymentFactory>(context, listen: false)
          .getPaymentGatewayId(paymentgateway.id);

      _gatewayController.text = updatedGateway.gateway_name!;
      _aliasController.text = updatedGateway.alias!;
      if (updatedGateway.settings != null) {
        _livekeyController.text = updatedGateway.settings!.live_secret_key!;
        _sandboxkeyController.text =
            updatedGateway.settings!.sandbox_secret_key!;
        _clientkeyController.text = updatedGateway.settings!.client_key!;
        _modeController.text = updatedGateway.settings!.mode!;
        _secretkeyController.text = updatedGateway.settings!.secret_key!;
        _publishkeyController.text = updatedGateway.settings!.publishable_key!;
        _redirectUriController.text = updatedGateway.settings!.redirect_uri!;
      }
      userStatus = updatedGateway.status!;
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
        key: _formKeyUpdatePaymentGateway,
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
                      controller: _gatewayController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Gateway*',
                        hintText: 'e.g Remita',
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
                      readOnly: false,
                      controller: _aliasController,
                      decoration: InputDecoration(
                        labelText: 'Gateway Alias',
                        hintText: 'e.g remita',
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
                    child: DropdownButtonHideUnderline(
                      child: InkWell(
                        onTap: () => openGatewaySetting(),
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Icon(
                                updatedGateway.settings != null &&
                                        getProperty.isVisible
                                    ? Icons.remove
                                    : Icons.add,
                                color: AppTheme.main,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Gateway Settings',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppTheme.main,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          items: const [],
                          buttonStyleData: getProperty.buttonStyleMethod(),
                          dropdownStyleData:
                              getProperty.dropDownStyleDataMethod(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text(
                      'Status',
                      style: TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                    ),
                    subtitle: !getProperty.isActive
                        ? Text(
                            'In Active',
                            style: TextStyle(
                              color: getProperty.isActive
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          )
                        : Text(
                            'Active',
                            style: TextStyle(
                              color: getProperty.isActive
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          ),
                    activeColor: AppTheme.main,
                    inactiveThumbColor: AppTheme.defaultTextColor,
                    inactiveTrackColor: AppTheme.grey,
                    value: getProperty.isActive,
                    onChanged: (bool value) {
                      setState(() {
                        getProperty.isActive = value;
                        if (value) {
                          userStatus = 1;
                        } else {
                          userStatus = 0;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: updatedGateway.settings != null
                  ? getProperty.isVisible
                  : !getProperty.isVisible,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _redirectUriController,
                            onChanged: (newValue) {
                              setState(() {
                                _redirectUriController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Redirect Uri',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _livekeyController,
                            onChanged: (newValue) {
                              setState(() {
                                _livekeyController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Live Secret Key',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _sandboxkeyController,
                            onChanged: (newValue) {
                              setState(() {
                                _sandboxkeyController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Sandbox Secret Key',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _clientkeyController,
                            onChanged: (newValue) {
                              setState(() {
                                _clientkeyController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Client Secret Key',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _modeController,
                            onChanged: (newValue) {
                              setState(() {
                                _modeController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Mode',
                              hintText: 'e.g Sandbox or Live',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _secretkeyController,
                            onChanged: (newValue) {
                              setState(() {
                                _secretkeyController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Secret Key',
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
                            style: const TextStyle(
                                color: AppTheme.defaultTextColor),
                            controller: _publishkeyController,
                            onChanged: (newValue) {
                              setState(() {
                                _publishkeyController.text = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Publishable Key',
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
            Opacity(
              opacity: getProperty.isLoading ? 1.0 : 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.main,
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
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const PaymentGatewayHome(),
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
              RouteService.paymentgateways(context);
            },
            child: Text(
              "Edit Gateway",
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
                      RouteService.paymentgateways(context);
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
    if (_formKeyUpdatePaymentGateway.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      PaymentGatewayUpdate paymentgatewayObject = PaymentGatewayUpdate(
        payment_gateway: _gatewayController.text,
        gateway_alias: _aliasController.text,
        gateway_settings: GatewaySetting(
          redirect_uri: _redirectUriController.text,
          publishable_key: _publishkeyController.text,
          secret_key: _secretkeyController.text,
          mode: _modeController.text,
          client_key: _clientkeyController.text,
          sandbox_secret_key: _sandboxkeyController.text,
          live_secret_key: _livekeyController.text,
        ),
        status: userStatus,
        id: updatedGateway.id,
      );

      await Provider.of<PaymentFactory>(context, listen: false)
          .updatePaymentGateway(paymentgatewayObject);

      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
      // returnHome();
    } else {
      snackBarError(ctx, _formKeyUpdatePaymentGateway);
    }
  }

  openGatewaySetting() {
    setState(() {
      getProperty.isVisible = !getProperty.isVisible;
    });
  }

  goBack() {
    RouteService.paymentgateways(context);
  }
}
