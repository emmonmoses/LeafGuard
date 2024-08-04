// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/currency/currency.dart';
import 'package:leafguard/models/currency/currency_update.dart';
import 'package:leafguard/services/currency/currencyFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/screens/currency/home.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditCurrency extends StatefulWidget {
  static const routeName = '/currencyupdate';

  const EditCurrency({super.key});

  @override
  State<EditCurrency> createState() => _EditCurrencyState();
}

class _EditCurrencyState extends State<EditCurrency> {
  late GlobalKey<FormState> _formKeyUpdateCurrency;

  final _currencyController = TextEditingController();
  final _codeController = TextEditingController();
  final _symbolController = TextEditingController();
  final _valueController = TextEditingController();

  int currencyStatus = 0;
  num currencyValue = 0;
  VariableService getProperty = VariableService();
  Currency updatedCurrency = Currency();

  @override
  void initState() {
    super.initState();
    _formKeyUpdateCurrency = GlobalKey();
  }

  @override
  void dispose() {
    _currencyController.dispose();
    _codeController.dispose();
    _symbolController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    final currency = ModalRoute.of(context)!.settings.arguments as Currency;

    if (getProperty.isInit) {
      updatedCurrency =
          await Provider.of<CurrencyFactory>(context, listen: false)
              .getCurrencyId(currency.id);

      _currencyController.text = updatedCurrency.name!;
      _codeController.text = updatedCurrency.code!;
      _symbolController.text = updatedCurrency.symbol!;
      // currencyValue = updatedCurrency.value as num;
      currencyStatus = updatedCurrency.status!;
      getProperty.isActive = currencyStatus == 1;
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
        key: _formKeyUpdateCurrency,
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
                      controller: _currencyController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Currency cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency*',
                        hintText: 'e.g Kenyan Shilling',
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
                      readOnly: false,
                      controller: _codeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Currency code cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency Code*',
                        hintText: 'e.g Ksh',
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
                      controller: _symbolController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Currency symbol cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency Symbol*',
                        hintText: 'e.g /=',
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
                    padding: const EdgeInsets.all(15),
                    child: NumberInputWithIncrementDecrement(
                      style: const TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                      controller: _valueController,
                      onIncrement: (num newlyIncrementedValue) {
                        setState(() {
                          currencyValue = newlyIncrementedValue;
                        });
                      },
                      onDecrement: (num newlyDecrementedValue) {
                        setState(() {
                          currencyValue = newlyDecrementedValue;
                        });
                      },
                      isInt: true,
                      min: 0,
                      incDecFactor: 1.0,
                      widgetContainerDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppTheme.grey,
                        ),
                      ),
                      numberFieldDecoration: const InputDecoration(
                        labelText: 'Currency Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    subtitle: currencyStatus == 1
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
                        currencyStatus = getProperty.isActive ? 1 : 0;
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
                  pageBuilder: (_, __, ___) => const CurrencyHome(),
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
              RouteService.currencies(context);
            },
            child: Text(
              "Edit Currency",
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
                      RouteService.currencies(context);
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
    if (_formKeyUpdateCurrency.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      CurrencyUpdate currencyObject = CurrencyUpdate(
        currency_symbol: _symbolController.text,
        currency_name: _currencyController.text,
        currency_code: _codeController.text,
        currency_value: currencyValue as int,
        currency_status: currencyStatus,
        id: updatedCurrency.id!,
      );
      await Provider.of<CurrencyFactory>(context, listen: false)
          .updateCurrency(currencyObject);
      setState(() {
        getProperty.isLoading = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
    } else {
      snackBarError(ctx, _formKeyUpdateCurrency);
    }
  }
}
