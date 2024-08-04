// ignore_for_file: prefer_typing_uninitialized_variables, prefer_if_null_operators
// Project imports:
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/service/service.dart';
import 'package:leafguard/models/service/service_update.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/services/serviceFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class EditService extends StatefulWidget {
  final String serviceId;

  const EditService({
    super.key,
    required this.serviceId,
  });

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  final _nameController = TextEditingController();
  final _taxNameController = TextEditingController();
  final _taskerController = TextEditingController();
  final _categoryController = TextEditingController();

  late GlobalKey<FormState> _formKeyUpdateSubCategory;

  int serviceStatus = 0;
  bool isChecked = false, taxType = true;
  String? selectedCategoryValue;
  String? selectedTaskerValue;
  String? selectedValue, ifCategoryValue;
  var imageName, iconName, activeIconName, category;
  VariableService getProperty = VariableService();

  int page = 1, pages = 1;
  CategoryFactory? fnc;
  List<Category> categories = [];
  ServiceProviderFactory? fnt;
  List<ServiceProvider> taskers = [];
  Service updatedService = Service();

  @override
  void initState() {
    super.initState();

    _formKeyUpdateSubCategory = GlobalKey();
  }

  @override
  void didChangeDependencies() {
    fnc = Provider.of<CategoryFactory>(context, listen: false);
    fnc!
        .getAllCategories(getProperty.search.page)
        .then((r) => {setCategories(fnc!)});

    fnt = Provider.of<ServiceProviderFactory>(context, listen: false);
    fnt!
        .getAllServiceProviders(getProperty.search.page)
        .then((r) => {setTaskers(fnt!)});

    if (getProperty.isInit) {
      updatedService = Provider.of<ServiceFactory>(context, listen: false)
          .getServiceId(widget.serviceId);

      _nameController.text = updatedService.name!;
      _taskerController.text = updatedService.tasker!.id!;
      serviceStatus = 1;
      getProperty.isTax = serviceStatus == 1;
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
        key: _formKeyUpdateSubCategory,
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
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _taskerController.text =
                              '${ApiEndPoint.prodHost}$value'.toLowerCase();
                          _taxNameController.text = value.toUpperCase();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Name*',
                        hintText: 'e.g John Doe',
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Category*',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: categories
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item.id,
                                child: Text(
                                  item.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppTheme.defaultTextColor,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedCategoryValue,
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryValue = value as String;
                            _categoryController.text = categories
                                .firstWhere((category) => category.id == value)
                                .id!;
                          });
                        },
                        buttonStyleData: getProperty.buttonStyleMethod(),
                        iconStyleData: getProperty.iconStyleMethod(),
                        dropdownStyleData:
                            getProperty.dropDownStyleDataMethod(),
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
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Tasker',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: taskers
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item.id,
                                child: item.name != null
                                    ? Text(
                                        item.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppTheme.defaultTextColor,
                                        ),
                                      )
                                    : Text(
                                        item.username!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppTheme.defaultTextColor,
                                        ),
                                      ),
                              ),
                            )
                            .toList(),
                        value: selectedTaskerValue,
                        onChanged: (value) {
                          setState(() {
                            selectedTaskerValue = value as String;
                            _taskerController.text = taskers
                                .firstWhere((tasker) => tasker.id == value)
                                .id!;
                          });
                        },
                        buttonStyleData: getProperty.buttonStyleMethod(),
                        iconStyleData: getProperty.iconStyleMethod(),
                        dropdownStyleData:
                            getProperty.dropDownStyleDataMethod(),
                      ),
                    ),
                  ),
                ),
              ],
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
              RouteService.subCategories(context);
            },
            child: const Icon(
              Icons.arrow_left,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              RouteService.subCategories(context);
            },
            child: Text(
              "Edit Service",
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
                      RouteService.subCategories(context);
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

  void setCategories(CategoryFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    setState(() {
      categories = fnc.categories;
    });
  }

  // void setDiscounts(DiscountFactory fnd) {
  //   pages = fnd.totalPages;
  //   page = fnd.currentPage;
  //   setState(() {
  //     discounts = fnd.discounts;
  //   });
  // }

  void setTaskers(ServiceProviderFactory fnt) {
    pages = fnt.totalPages;
    page = fnt.currentPage;
    setState(() {
      taskers = fnt.serviceproviders;
    });
  }

  // void setTaxes(TaxFactory fnx) {
  //   pages = fnx.totalPages;
  //   page = fnx.currentPage;
  //   setState(() {
  //     taxess = fnx.taxes;
  //   });
  // }

  Row buildDropDownRow(Category cat) {
    return Row(
      children: <Widget>[
        Text(cat.name ?? "Select Category"),
      ],
    );
  }

  save(ctx) async {
    if (_formKeyUpdateSubCategory.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      ServiceUpdate serviceObject = ServiceUpdate(
        id: widget.serviceId,
        taskerId: _taskerController.text,
        // name: _nameController.text,
        // price: _priceController.text,
        // price_rate: _rateTypeController.text,
        // categoryId: _categoryController.text,
        // tax: Tax(
        //   name: _taxNameController.text,
        //   type: taxStatus,
        //   rate: _taxRateController.text,
        // ),
        // discount: Discount(
        //   name: _discountNameController.text,
        //   rate: _discountRateController.text,
        // ),
        // commissionRate: _commissionController.text,
        // status: serviceStatus,
      );
      await Provider.of<ServiceFactory>(context, listen: false)
          .updateService(serviceObject);
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
    } else {
      snackBarError(ctx, _formKeyUpdateSubCategory);
    }
  }
}
