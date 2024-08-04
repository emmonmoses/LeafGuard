// ignore_for_file: prefer_typing_uninitialized_variables
// Project imports:
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/company/company_address.dart';
import 'package:leafguard/models/company/company_create.dart';
import 'package:leafguard/models/company/company_price.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/company/companyFactory.dart';
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

class CreateCompany extends StatefulWidget {
  const CreateCompany({Key? key}) : super(key: key);

  @override
  CreateCompanyState createState() => CreateCompanyState();
}

class CreateCompanyState extends State<CreateCompany> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _tinnumberContoller = TextEditingController();
  final _cityController = TextEditingController();
  final _currencyController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _countryController = TextEditingController();
  final _avaterController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _priceController = TextEditingController();
  int companyStatus = 1;
  VariableService dataservice = VariableService();
  List<MainCategory> categories = [];
  List<Category>? subCategories = [];
  MainCategoryFactory? fnc;
  CategoryFactory? fns;
  String? selectedCategoryValue, selectedValue, ifCategoryValue;
  String? selectedPaymentType;
  var attachmentName, attachmentSize, attachmentStream;
  PlatformFile? objFile;

  String? selectedSubCategoryValue;
  int page = 1, pages = 25;

  late GlobalKey<FormState> _formKeyCreateCompany;

  final baseUrl = ApiEndPoint.adminLogo;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _formKeyCreateCompany = GlobalKey();
  }

  @override
  Future<void> didChangeDependencies() async {
    await getMainCategories();
    super.didChangeDependencies();
  }

  getMainCategories() async {
    fnc = Provider.of<MainCategoryFactory>(context, listen: false);
    await fnc!.getAllMainCategories(dataservice.search.page);
    setCategories(fnc!);
  }

  getServiceByMainCategoryId(categoryId) async {
    fns = Provider.of<CategoryFactory>(context, listen: false);

    await fns!.getCategoriesByMainCategoryId(categoryId, 1);

    setSubCategories(fns!);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _tinnumberContoller.dispose();
    _cityController.dispose();
    _currencyController.dispose();
    _phoneCodeController.dispose();
    _phoneNumController.dispose();
    _descriptionController.dispose();
    _countryController.dispose();
    _avaterController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  clear() {
    _nameController.clear();
    _emailController.clear();
    _usernameController.clear();
    _tinnumberContoller.clear();
    _cityController.clear();
    _currencyController.clear();
    _phoneCodeController.clear();
    _phoneNumController.clear();
    _descriptionController.clear();
    _countryController.clear();
    _avaterController.clear();
    _categoryController.clear();
    _subCategoryController.clear();
    _priceController.clear();
    selectedSubCategoryValue == null;
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
        key: _formKeyCreateCompany,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newCompanyHeader,
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
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Company Name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Company Name must be at least 2 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Company Name*',
                        hintText: 'e.g AppliedLine  ',
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
                      controller: _tinnumberContoller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'tinnumber cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'tinnumber*',
                        hintText: 'e.g 10000',
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
                            getServiceByMainCategoryId(
                                _categoryController.text);
                          });
                        },
                        buttonStyleData: dataservice.buttonStyleMethod(),
                        iconStyleData: dataservice.iconStyleMethod(),
                        dropdownStyleData:
                            dataservice.dropDownStyleDataMethod(),
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
                                'Select Sub Catagory*',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: subCategories!
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
                        value: selectedSubCategoryValue,
                        onChanged: (value) {
                          setState(() {
                            selectedSubCategoryValue = value as String;
                            _subCategoryController.text = subCategories!
                                .firstWhere(
                                    (subCategory) => subCategory.id == value)
                                .id!;
                          });
                        },
                        buttonStyleData: dataservice.buttonStyleMethod(),
                        iconStyleData: dataservice.iconStyleMethod(),
                        dropdownStyleData:
                            dataservice.dropDownStyleDataMethod(),
                      ),
                    ),
                  ),
                )
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
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return "Invalid Email";
                        }
                        final parts = value.split('@');
                        if (parts.length != 2) {
                          return "Invalid Email";
                        }
                        final localPart = parts[0];
                        final domainPart = parts[1];

                        if (localPart.isEmpty || localPart.length > 64) {
                          return "Invalid Email";
                        }

                        if (domainPart.isEmpty || domainPart.length > 255) {
                          return "Invalid Email";
                        }

                        if (!domainPart.contains('.')) {
                          return "Invalid Email";
                        }

                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      readOnly: false,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address*',
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
                      controller: _descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description cannot be empty';
                        } else if (value.length < 3) {
                          return 'Description must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description*',
                        hintText: 'e.g About Company  ',
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
                      controller: _currencyController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Currency cannot be empty';
                        } else if (value.length < 3) {
                          return 'Currency must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency*',
                        hintText: 'e.g ETB  ',
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
                                'Select Payment Type*',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: ['Hourly', 'Monthly'].map(
                          (String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppTheme.defaultTextColor,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        value: selectedPaymentType,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentType = value as String;
                          });
                        },
                        buttonStyleData: dataservice.buttonStyleMethod(),
                        iconStyleData: dataservice.iconStyleMethod(),
                        dropdownStyleData:
                            dataservice.dropDownStyleDataMethod(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _priceController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Price cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price*',
                        hintText: 'e.g 1000',
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
                      readOnly: true,
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _countryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Country name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Country name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Country*',
                        hintText: 'e.g Kenya',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onTap: () {
                        setState(() {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              _countryController.text = country.name;
                            },
                          );
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'City cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'City*',
                        hintText: 'e.g Addis Ababa',
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
                    child: IntlPhoneField(
                      style: const TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                      // controller: _phoneController2,
                      autovalidateMode: AutovalidateMode.always,

                      validator: (value) {
                        if (value == null) {
                          return 'Phone number cannot be empty';
                        }

                        if (value.number.isEmpty) {
                          return 'Phone number is required';
                        }

                        if (value.number.length > 9) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number*',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        alignLabelWithHint: true,
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        setState(() {
                          _phoneCodeController.text = phone.countryCode;
                          _phoneNumController.text = phone.number;
                        });
                      },
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
                          companyStatus = 1;
                        } else {
                          companyStatus = 0;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () => chooseFile(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.main,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: Text(
                          "Upload Company Logo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: _avaterController.text.isNotEmpty,
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        style:
                            const TextStyle(color: AppTheme.defaultTextColor),
                        readOnly: true,
                        controller: _avaterController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Upload Company Image';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Profile Picture',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
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

  Widget get newCompanyHeader {
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
              RouteService.companies(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.companies(context);
            },
            child: Text(
              "New Company",
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
                      RouteService.companies(context);
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
    if (selectedCategoryValue == null) {
      snackBarErr(ctx, 'Select the main category');

      return;
    }

    if (selectedSubCategoryValue == null) {
      snackBarErr(ctx, 'Select the sub category');
      return;
    }

    if (selectedPaymentType == null) {
      snackBarErr(ctx, 'Select payment method');
      return;
    }

    if (_avaterController.text.isEmpty) {
      snackBarErr(ctx, 'Upload Company Logo');
      return;
    }
    if (_formKeyCreateCompany.currentState!.validate()) {
      setState(() {
        dataservice.isLoading = true;
      });

      var company = CompanyCreate(
        address: CompanyAddress(
          city: _cityController.text,
          country: _countryController.text,
        ),
        categoryId: _subCategoryController.text,
        currency: _currencyController.text,
        description: _descriptionController.text,
        email: _emailController.text,
        avatar: _avaterController.text,
        phone: Phone(
            code: _phoneCodeController.text, number: _phoneNumController.text),
        name: _nameController.text,
        pricing: selectedPaymentType == 'Hourly'
            ? CompanyPrice(
                hourly: double.tryParse(_priceController.text),
              )
            : CompanyPrice(monthly: double.tryParse(_priceController.text)),
        status: companyStatus == 1 ? true : false,
        tinnumber: _tinnumberContoller.text,
      );

      var provider = Provider.of<CompanyFactory>(context, listen: false);
      var result = await provider.createCompany(company);

      if (result == "Company Created Successfully") {
        await provider.uploadImage(
            attachmentName: attachmentName,
            attachmentSize: attachmentSize,
            attachmentStream: attachmentStream);

        setState(() {
          dataservice.isLoading = false;
        });

        clear();
        snackBarNotification(ctx, result);
      } else {
        snackBarErr(ctx, result);
      }
    } else {
      snackBarError(ctx, _formKeyCreateCompany);
    }
  }

  chooseFile() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile = result.files.single;
        attachmentName = objFile!.name;
        attachmentStream = objFile!.readStream;
        attachmentSize = objFile!.size;
      });
      _avaterController.text = attachmentName.toString();
    }
  }

  void setCategories(MainCategoryFactory fnc) {
    pages = 20;
    page = 1;
    setState(() {
      categories = fnc.categories;
    });
  }

  void setSubCategories(CategoryFactory fns) {
    pages = 100;
    page = 1;
    setState(() => subCategories = fns.categories);
  }
}
