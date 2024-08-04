// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:

import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/cancellation/cancellation.dart';
import 'package:leafguard/models/cancellation/cancellation_update.dart';
import 'package:leafguard/services/cancellation/cancellationFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/screens/cancellationrule/home.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditCancellation extends StatefulWidget {
  static const routeName = '/cancellationupdate';

  const EditCancellation({super.key});

  @override
  State<EditCancellation> createState() => _EditCancellationState();
}

class _EditCancellationState extends State<EditCancellation> {
  late GlobalKey<FormState> _formKeyUpdateCancellation;

  final _reasonController = TextEditingController();
  final _typeController = TextEditingController();

  int ruleStatus = 0;
  int ruleValue = 0;
  String dropdownValue = 'Choose a user';
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();
    _formKeyUpdateCancellation = GlobalKey();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  CancellationRules updatedCancellationRule = CancellationRules();

  @override
  Future<void> didChangeDependencies() async {
    final currency =
        ModalRoute.of(context)!.settings.arguments as CancellationRules;

    if (getProperty.isInit) {
      setState(() {
        getProperty.isLoading = true;
      });
      updatedCancellationRule =
          await Provider.of<CancellationFactory>(context, listen: false)
              .getCancellationId(currency.id);

      _reasonController.text = updatedCancellationRule.reason!;
      _typeController.text = updatedCancellationRule.type!;
      ruleStatus = updatedCancellationRule.status!;

      dropdownValue = updatedCancellationRule.type.toString();
      getProperty.isActive = ruleStatus == 1;
    }
    setState(() {
      getProperty.isLoading = false;
    });
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
                child: getProperty.isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: AppTheme.main),
                      )
                    : _buildForm,
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
        key: _formKeyUpdateCancellation,
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
                      controller: _reasonController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Reason cannot be empty';
                        } else if (value.length < 3) {
                          return 'Reason must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Cancellation Reason*',
                        hintText: 'e.g Low Cost',
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
                    margin: const EdgeInsets.only(left: 15.0),
                    padding: const EdgeInsets.all(15.0),
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.defaultTextColor,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: AppTheme.defaultTextColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          dropdownValue == 'Provider'
                              ? _typeController.text = 'Provider'
                              : _typeController.text = 'Customer';
                        });
                      },
                      items: <String>[
                        // 'Choose a user',
                        'Provider',
                        'Customer',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          //enabled: value != 'Choose a user',
                          child: Text(value),
                        );
                      }).toList(),
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
                    subtitle: ruleStatus == 1
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
                        ruleStatus = getProperty.isActive ? 1 : 0;
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
                  pageBuilder: (_, __, ___) => const CancellationHome(),
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
              RouteService.cancellations(context);
            },
            child: Text(
              "Edit CancellationRule",
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
                      RouteService.cancellations(context);
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
    if (_formKeyUpdateCancellation.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      CancellationRuleUpdate currencyObject = CancellationRuleUpdate(
        cancellation_reason: _reasonController.text,
        cancellation_user_type: _typeController.text,
        cancellation_status: ruleStatus,
        id: updatedCancellationRule.id!,
      );

      await Provider.of<CancellationFactory>(context, listen: false)
          .updateCancellation(currencyObject);
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateCancellation);
    }
  }

  goBack() {
    RouteService.cancellations(context);
  }
}
