// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/discount/discount_update.dart';
import 'package:leafguard/screens/discount/home.dart';
import 'package:leafguard/services/discount/discountFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditDiscount extends StatefulWidget {
  static const routeName = '/discountupdate';

  const EditDiscount({super.key});

  @override
  State<EditDiscount> createState() => _EditDiscountState();
}

class _EditDiscountState extends State<EditDiscount> {
  late GlobalKey<FormState> _formKeyUpdateDiscount;

  final _couponController = TextEditingController();
  final _codeController = TextEditingController();
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  int couponStatus = 0;
  String? couponValue = "0";
  VariableService getProperty = VariableService();
  Discount updatedDiscount = Discount();

  @override
  void initState() {
    super.initState();
    _formKeyUpdateDiscount = GlobalKey();
  }

  @override
  void dispose() {
    _couponController.dispose();
    _codeController.dispose();
    _typeController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> selectDate(TextEditingController controller) async {
    await VariableService.selectDate(
        controller, _fromController, _toController, context);
  }

  @override
  Future<void> didChangeDependencies() async {
    final coupon = ModalRoute.of(context)!.settings.arguments as Discount;

    if (getProperty.isInit) {
      updatedDiscount =
          await Provider.of<DiscountFactory>(context, listen: false)
              .getDiscountId(coupon.id);

      _couponController.text = updatedDiscount.name!;
      _codeController.text = updatedDiscount.code!;
      _typeController.text = updatedDiscount.discount_type!;
      couponValue = updatedDiscount.amount_percentage.toString();
      _descriptionController.text = updatedDiscount.description!;
      _fromController.text = DateFormat('yyyy-MM-dd').format(
        updatedDiscount.valid_from!,
      );
      _toController.text = DateFormat('yyyy-MM-dd').format(
        updatedDiscount.expiry_date!,
      );
      setState(() {
        couponStatus = updatedDiscount.status!;
        getProperty.isActive = couponStatus == 1;
      });
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
        key: _formKeyUpdateDiscount,
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
                      controller: _couponController,
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
                    subtitle: couponStatus == 1
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
                        couponStatus = getProperty.isActive ? 1 : 0;
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
                  pageBuilder: (_, __, ___) => const DiscountHome(),
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
              RouteService.discounts(context);
            },
            child: Text(
              "Edit Discount",
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
    if (_formKeyUpdateDiscount.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      DiscountUpdate couponObject = DiscountUpdate(
        id: updatedDiscount.id!,
        name: _couponController.text,
        code: _codeController.text,
        discount_type: _typeController.text,
        description: _descriptionController.text,
        rate: couponValue,
        valid_from: _fromController.text,
        expiry_date: _toController.text,
        status: couponStatus,
      );
      await Provider.of<DiscountFactory>(context, listen: false)
          .updateDiscount(couponObject);
      setState(() {
        getProperty.isLoading = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateDiscount);
    }
  }

  goBack() {
    RouteService.discounts(context);
  }
}
