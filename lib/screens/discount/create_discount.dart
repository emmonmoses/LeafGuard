// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
// Project imports:
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/discount/discountFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
// import 'package:number_inc_dec/number_inc_dec.dart';

class CreateDiscount extends StatefulWidget {
  const CreateDiscount({Key? key}) : super(key: key);

  @override
  CreateDiscountState createState() => CreateDiscountState();
}

class CreateDiscountState extends State<CreateDiscount> {
  late GlobalKey<FormState> _formKeyCreateDiscount;

  final _discountController = TextEditingController();
  final _codeController = TextEditingController();
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  int discountStatus = 0;
  num discountValue = 0;
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();
    _formKeyCreateDiscount = GlobalKey();
    _codeController.text = getProperty.generateRandomValue().toUpperCase();
    _typeController.text = 'Fixed Amount';
  }

  Future<void> selectDate(TextEditingController controller) async {
    await VariableService.selectDate(
        controller, _fromController, _toController, context);
  }

  @override
  void dispose() {
    _discountController.dispose();
    _codeController.dispose();
    _typeController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _fromController.dispose();
    _toController.dispose();
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
        key: _formKeyCreateDiscount,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newDiscountHeader,
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
                      controller: _discountController,
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      readOnly: true,
                      controller: _codeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Discount code cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Discount Code*',
                        hintText: 'e.g YLY-0YL01',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.only(left: 15.0),
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton<String>(
                        value: getProperty.dropdownRate,
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
                            getProperty.dropdownRate = newValue!;
                            getProperty.dropdownRate == 'Fixed Amount'
                                ? _typeController.text = 'Fixed Amount'
                                : getProperty.dropdownRate ==
                                        'Percentage Discount'
                                    ? _typeController.text =
                                        'Percentage Discount'
                                    : _typeController.text = 'Fixed Amount';
                          });
                        },
                        items: <String>[
                          'Rate Type*',
                          'Fixed Amount',
                          'Percentage Discount',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            enabled: value != getProperty.dropdownRate,
                            child: value == getProperty.dropdownRate
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
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Handle changes to the text field value
                          // You can update your discountValue or perform other actions here
                          // For example, if discountValue is expected to be an integer, you can parse it like this:
                          setState(() {
                            discountValue = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Amount*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _descriptionController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'e.g Valid while stock last',
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
                          discountStatus = 1;
                        } else {
                          discountStatus = 0;
                        }
                      });
                    },
                  ),
                ),
              ],
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

  Widget get newDiscountHeader {
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
              RouteService.discounts(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.discounts(context);
            },
            child: Text(
              "New Discount",
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
                      RouteService.discounts(context);
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
    if (_formKeyCreateDiscount.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      await Provider.of<DiscountFactory>(context, listen: false).createDiscount(
        _discountController.text,
        _codeController.text,
        _typeController.text,
        _descriptionController.text,
        discountValue,
        _fromController.text,
        _toController.text,
        discountStatus,
      );
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      clear();
      // returnHome();
    } else {
      snackBarError(ctx, _formKeyCreateDiscount);
    }
  }

  clear() {
    _discountController.clear();
    // _codeController.clear();
    _typeController.clear();
    _descriptionController.clear();
    _amountController.clear();
    _fromController.clear();
    _toController.clear();
  }
}
