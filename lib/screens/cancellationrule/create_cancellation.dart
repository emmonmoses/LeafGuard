// ignore_for_file: prefer_typing_uninitialized_variables
// Project imports:
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/cancellation/cancellationFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreateCancellation extends StatefulWidget {
  const CreateCancellation({Key? key}) : super(key: key);

  @override
  CreateCancellationState createState() => CreateCancellationState();
}

class CreateCancellationState extends State<CreateCancellation> {
  late GlobalKey<FormState> _formKeyCreateCancellation;

  final _reasonController = TextEditingController();
  final _typeController = TextEditingController();

  int ruleStatus = 0;
  String dropdownValue = 'Choose a user';
  VariableService dataservice = VariableService();

  @override
  void initState() {
    super.initState();
    _formKeyCreateCancellation = GlobalKey();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _typeController.dispose();
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
        key: _formKeyCreateCancellation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newCancellationHeader,
            Divider(
              thickness: AppTheme.dividerThickness,
              color: AppTheme.main,
            ),
            Visibility(
              visible: dataservice.isVisible,
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
                        'Choose a user',
                        'Provider',
                        'Customer',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != 'Choose a user',
                          child: value == 'Choose a user'
                              ? Text(
                                  value,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                  ),
                                )
                              : Text(
                                  value,
                                  style: const TextStyle(
                                    color: AppTheme.defaultTextColor,
                                  ),
                                ),
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
                    subtitle: !dataservice.isActive
                        ? Text(
                            'In Active',
                            style: TextStyle(
                              color: dataservice.isActive
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          )
                        : Text(
                            'Active',
                            style: TextStyle(
                              color: dataservice.isActive
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          ),
                    activeColor: AppTheme.main,
                    inactiveThumbColor: AppTheme.defaultTextColor,
                    inactiveTrackColor: AppTheme.grey,
                    value: dataservice.isActive,
                    onChanged: (bool value) {
                      setState(() {
                        dataservice.isActive = value;
                        if (value) {
                          ruleStatus = 1;
                        } else {
                          ruleStatus = 0;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: dataservice.isLoading ? 1.0 : 0,
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

  Widget get newCancellationHeader {
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
              RouteService.cancellations(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.cancellations(context);
            },
            child: Text(
              "New Cancellation",
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
    if (_typeController.text.isEmpty) {
      snackBarErr(context, 'Choose a User');
      return;
    }
    if (_formKeyCreateCancellation.currentState!.validate()) {
      setState(() {
        dataservice.isLoading = true;
      });
      await Provider.of<CancellationFactory>(context, listen: false)
          .createCancellation(
        _reasonController.text,
        _typeController.text,
        ruleStatus,
      );
      setState(() {
        dataservice.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      clear();
    } else {
      snackBarError(ctx, _formKeyCreateCancellation);
    }
  }

  clear() {
    _reasonController.clear();
    setState(() {
      ruleStatus = 1;
    });
    _typeController.clear();
    dropdownValue = 'Choose a user';
  }
}
