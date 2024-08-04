// ignore_for_file: prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, unused_field
// Project imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/discount/discount_catagory.dart';
import 'package:leafguard/models/seo/seo.dart';
import 'package:leafguard/models/skills/skills.dart';
import 'package:leafguard/models/tax/tax.dart';
import 'package:leafguard/models/tax/tax_catagory.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/discount/discountFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/tax/taxFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:http/http.dart' as http;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  CreateCategoryState createState() => CreateCategoryState();
}

class CreateCategoryState extends State<CreateCategory> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _pictureController = TextEditingController();

  int userStatus = 0;
  int serviceStatus = 0;
  bool isChecked = false;
  bool taxStatus = true;
  var imageName, iconName, activeIconName;
  List<Discount> discounts = [];
  String? selectedDiscountValue;

  MainCategoryFactory? fnc;
  DiscountFactory? fnd;
  TaxFactory? fnx;
  Seo seo = Seo();
  PlatformFile? objFile;
  VariableService getProperty = VariableService();
  List<ServiceProviderSkills> skills = [];
  String? selectedCategoryValue;
  int page = 1, pages = 1;

  List<MainCategory> categories = [];
  List<Tax> taxess = [];
  String? selectedTaxValue;

  late GlobalKey<FormState> _formKeyCreateCategory;
  final _taxNameController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _discountNameController = TextEditingController();
  final _discountRateController = TextEditingController();
  final _priceController = TextEditingController();
  final _rateTypeController = TextEditingController();
  final _agentCommissionController = TextEditingController();
  final _adminCommissionController = TextEditingController();

  @override
  void initState() {
    _formKeyCreateCategory = GlobalKey();
    // _priceController.text = "0";
    _taxRateController.text = "0";
    _discountRateController.text = "0";
    _adminCommissionController.text = "10";
    _agentCommissionController.text = "10"; // default commission rate to 10%
    _rateTypeController.text = "hourly"; // default to hourly rate
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fnc = Provider.of<MainCategoryFactory>(context, listen: false);
    fnc!.getAllMainCategories(getProperty.search.page);
    setCategories(fnc!);

    fnd = Provider.of<DiscountFactory>(context, listen: false);
    fnd!.getAllDiscounts(getProperty.search.page);
    setDiscounts(fnd!);

    fnx = Provider.of<TaxFactory>(context, listen: false);
    fnx!.getAllTaxes(getProperty.search.page);
    setTaxes(fnx!);

    super.didChangeDependencies();
  }

  void setDiscounts(DiscountFactory fnd) {
    pages = fnd.totalPages;
    page = fnd.currentPage;
    setState(() {
      discounts = fnd.discounts;
    });
  }

  void setTaxes(TaxFactory fnx) {
    pages = fnx.totalPages;
    page = fnx.currentPage;
    setState(() {
      taxess = fnx.taxes;
    });
  }

  void setCategories(MainCategoryFactory fnc) {
    pages = fnc.totalPages;
    page = fnc.currentPage;
    setState(() {
      categories = fnc.categories;
    });
  }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _categoryController.dispose();
  //   _imageController.dispose();
  //   _descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // loadData();
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
        key: _formKeyCreateCategory,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newCategoryHeader,
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
                      // onChanged: (value) {
                      //   setState(() {
                      //     _taxNameController.text = value.toUpperCase();
                      //   });
                      // },
                      decoration: InputDecoration(
                        labelText: 'Name*',
                        hintText: 'e.g Plumber',
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
                                'Select Main Catagory*',
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
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Hourly price is required";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _priceController,
                      onChanged: (value) {
                        setState(() {
                          // _priceController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Hourly Price',
                        hintText: 'e.g 10',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Image for catagory is required";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      keyboardType: TextInputType.text,
                      controller: _pictureController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            'Click the icon on the right to upload picture',
                        hintText: 'Profile Picture',
                        hintStyle: TextStyle(
                          color: AppTheme.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.camera,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            chooseFileAvatar();
                          },
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
                                'Select Discount',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: discounts
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
                        value: selectedDiscountValue,
                        onChanged: (value) {
                          setState(() {
                            selectedDiscountValue = value as String;
                            _discountNameController.text = discounts
                                .firstWhere((discount) => discount.id == value)
                                .name!
                                .toString();
                            _discountRateController.text = discounts
                                .firstWhere((discount) => discount.id == value)
                                .rate!
                                .toString();
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _discountRateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Select the discount type and give the rate";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Rate',
                        hintText:
                            'e.g Select discount and the value will be applied here',
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
                                'Select Tax',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: taxess
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
                        value: selectedTaxValue,
                        onChanged: (value) {
                          setState(() {
                            selectedTaxValue = value as String;
                            _taxNameController.text = taxess
                                .firstWhere((tax) => tax.id == value)
                                .name!
                                .toString();
                            _taxRateController.text = taxess
                                .firstWhere((tax) => tax.id == value)
                                .rate!
                                .toString();
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Select the Tax type and give the rate";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _taxRateController,
                      decoration: InputDecoration(
                        labelText: 'Rate',
                        hintText:
                            'e.g Select tax and the value will be applied here',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text(
                      'Tax Type',
                      style: TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                    ),
                    subtitle: !getProperty.isTax
                        ? Text(
                            'Tax Optional',
                            style: TextStyle(
                              color: getProperty.isTax
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          )
                        : Text(
                            'Tax Mandatory',
                            style: TextStyle(
                              color: getProperty.isTax
                                  ? AppTheme.main
                                  : AppTheme.red,
                            ),
                          ),
                    activeColor: AppTheme.main,
                    inactiveThumbColor: AppTheme.defaultTextColor,
                    inactiveTrackColor: AppTheme.grey,
                    value: getProperty.isTax,
                    onChanged: (bool value) {
                      setState(() {
                        getProperty.isTax = value;
                        if (value) {
                          taxStatus = true;
                        } else {
                          taxStatus = false;
                        }
                      });
                    },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Commission is required";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _adminCommissionController,
                      onChanged: (value) {
                        setState(() {
                          _adminCommissionController.text =
                              '${ApiEndPoint.prodHost}$value'.toLowerCase();
                          _adminCommissionController.text = value.toUpperCase();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Admin Commission Rate',
                        hintText: 'e.g 10',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Commission is required";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _agentCommissionController,
                      onChanged: (value) {
                        setState(() {
                          _agentCommissionController.text =
                              '${ApiEndPoint.prodHost}$value'.toLowerCase();
                          _agentCommissionController.text = value.toUpperCase();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Agent Commission Rate',
                        hintText: 'e.g 10',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                          serviceStatus = 1;
                        } else {
                          serviceStatus = 0;
                        }
                      });
                    },
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
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description is required";
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'e.g Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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

  Widget get newCategoryHeader {
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
              RouteService.categories(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.categories(context);
            },
            child: Text(
              "New Category",
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
                      RouteService.categories(context);
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
    if (_formKeyCreateCategory.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
        getProperty.isInvisible = true;
      });

      var tax = TaxCatagory(
        name: _taxNameController.text,
        type: taxStatus,
        rate: _taxRateController.text,
      );

      var discount = DiscountCatagory(
        name: _discountNameController.text,
        rate: _discountRateController.text,
      );

      await Provider.of<CategoryFactory>(context, listen: false).createCategory(
        name: _nameController.text,
        maincategory: _categoryController.text,
        description: _descriptionController.text,
        image: _pictureController.text,
        status: serviceStatus,
        adminCommission: _adminCommissionController.text,
        // agentCommission: _agentCommissionController.text,
        discount: discount,
        tax: tax,
        price: _priceController.text,
      );

      await uploadFileAvatar();

      setState(() {
        getProperty.isLoading = false;
        getProperty.isInvisible = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      clear();
    } else {
      snackBarError(ctx, _formKeyCreateCategory);
    }
  }

  var attachmentNameAvatar, attachmentSizeAvatar, attachmentStreamAvatar;
  PlatformFile? objFileAvatar;

  chooseFileAvatar() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFileAvatar = result.files.single;
        attachmentNameAvatar = objFileAvatar!.name;
        attachmentStreamAvatar = objFileAvatar!.readStream;
        attachmentSizeAvatar = objFileAvatar!.size;
      });
      _pictureController.text = attachmentNameAvatar.toString();
      // await uploadFileAvatar();
    }
  }

  uploadFileAvatar() async {
    String postUrl = "${ApiEndPoint.endpoint}/newcategories/upload";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "avatar",
      attachmentStreamAvatar,
      attachmentSizeAvatar,
      filename: attachmentNameAvatar,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => toastError(err));
  }

  clear() {
    _nameController.clear();
    _categoryController.clear();
    _descriptionController.clear();
    _pictureController.clear();
    _adminCommissionController.text = '10';
    _agentCommissionController.text = '10';
    _discountNameController.clear();
    _discountRateController.text = '0';
    _taxNameController.clear();
    _taxRateController.text = '0';
    _priceController.clear();
    attachmentNameAvatar = '';
  }
}
