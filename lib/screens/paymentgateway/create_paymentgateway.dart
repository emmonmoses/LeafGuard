// ignore_for_file: prefer_typing_uninitialized_variables
// Project imports:
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/gatewaySetting/gatewaysetting.dart';
import 'package:leafguard/services/paymentgateway/paymentGatewayFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreatePaymentGateway extends StatefulWidget {
  const CreatePaymentGateway({Key? key}) : super(key: key);

  @override
  CreatePaymentGatewayState createState() => CreatePaymentGatewayState();
}

class CreatePaymentGatewayState extends State<CreatePaymentGateway> {
  final _gatewayController = TextEditingController();
  final _aliasController = TextEditingController();
  final _livekeyController = TextEditingController();
  final _sandboxkeyController = TextEditingController();
  final _clientkeyController = TextEditingController();
  final _modeController = TextEditingController();
  final _secretkeyController = TextEditingController();
  final _publishkeyController = TextEditingController();
  final _redirectUriController = TextEditingController();

  int userStatus = 0;
  GatewaySetting gateway = GatewaySetting();
  VariableService getProperty = VariableService();

  late GlobalKey<FormState> _formKeyCreatePaymentGateway;

  final baseUrl = ApiEndPoint.getProviderImage;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _formKeyCreatePaymentGateway = GlobalKey();
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
        key: _formKeyCreatePaymentGateway,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newPaymentGatewayHeader,
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
                                !getProperty.isInvisible
                                    ? Icons.add
                                    : Icons.remove,
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
              visible: getProperty.isInvisible,
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

  Widget get newPaymentGatewayHeader {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(
                Icons.menu,
                color: AppTheme.defaultTextColor,
              ),
              onPressed:
                  Provider.of<custom.MenuController>(context, listen: false)
                      .controlMenu,
            ),
          InkWell(
            child: const Icon(
              Icons.arrow_left,
            ),
            onTap: () {
              RouteService.paymentgateways(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.paymentgateways(context);
            },
            child: Text(
              "New Gateway",
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
    if (_formKeyCreatePaymentGateway.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      await Provider.of<PaymentFactory>(context, listen: false)
          .createPaymentGateway(
        _gatewayController.text,
        _aliasController.text,
        gateway = GatewaySetting(
          redirect_uri: _redirectUriController.text,
          publishable_key: _publishkeyController.text,
          secret_key: _secretkeyController.text,
          mode: _modeController.text,
          client_key: _clientkeyController.text,
          sandbox_secret_key: _sandboxkeyController.text,
          live_secret_key: _livekeyController.text,
        ),
        userStatus,
      );
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
      // returnHome();
    } else {
      snackBarError(ctx, _formKeyCreatePaymentGateway);
    }
  }

  openGatewaySetting() {
    setState(() {
      getProperty.isInvisible = !getProperty.isInvisible;
    });
  }

  goBack() {
    RouteService.paymentgateways(context);
  }
}
