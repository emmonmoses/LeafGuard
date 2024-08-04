// ignore_for_file: prefer_typing_uninitialized_variables
// Project imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/provider/provider_create_return.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/services/serviceFactory.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  CreateServiceState createState() => CreateServiceState();
}

class CreateServiceState extends State<CreateService> {
  final _nameController = TextEditingController();
  final _serviceproviderId = TextEditingController();
  final _mainCategoryController = TextEditingController();
  late GlobalKey<FormState> _formKeyCreateSubCategory;
  VariableService getProperty = VariableService();

  bool isChecked = false, taxType = true;
  String? selectedCategoryValue;
  String? selectedTaskerValue;
  bool isSent = false;
  bool isLoading = false;
  int page = 1, pages = 1;
  int serviceStatus = 0;

  CategoryFactory? fnc;
  MainCategoryFactory? fnm;
  ServiceProviderFactory? fnp;
  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  ServiceProviderFactory? fnt;
  ProviderCreateReturn? taskers;
  List<String> selectedCatagoryByAgent = [];
  String? selectedMainCatagoryByAgent;

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _taskerController.dispose();
  //   _taxNameController.dispose();
  //   _taxRateController.dispose();
  //   _categoryController.dispose();
  //   _discountNameController.dispose();
  //   _discountRateController.dispose();
  //   _priceController.dispose();
  //   _commissionController.dispose();
  //   _rateTypeController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    _formKeyCreateSubCategory = GlobalKey();
  }

  callCategoriesByMainCat({id}) async {
    setState(() {
      isLoading = true;
    });
    fnc = Provider.of<CategoryFactory>(context, listen: false);
    await fnc!
        .getCategoriesByMainCategoryId(id, getProperty.search.page)
        .then((r) => {setCategories(fnc!)});

    setState(() {
      isLoading = false;
    });
  }

  callGetProviderById({id}) async {
    setState(() {
      isLoading = true;
      isSent = true;
    });

    fnp = Provider.of<ServiceProviderFactory>(context, listen: false);
    await fnp!.getUserByTaskerNumber(id).then((r) => {setTaskers(fnp!)});
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      getProperty.isLoading = true;
      getProperty.isInvisible = true;
    });
    fnm = Provider.of<MainCategoryFactory>(context, listen: false);
    await fnm!
        .getAllMainCategories(getProperty.search.page)
        .then((r) => {setMainCategories(fnm!)});

    // fnt = Provider.of<ServiceProviderFactory>(context, listen: false);
    // fnt!
    //     .getAllServiceProviders(getProperty.search.page)
    //     .then((r) => {setTaskers(fnt!)});

    setState(() {
      getProperty.isLoading = false;
      getProperty.isInvisible = false;
    });
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
        key: _formKeyCreateSubCategory,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newSubCategoryHeader,
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
                // Expanded(
                //   child: Container(
                //     padding: const EdgeInsets.all(15.0),
                //     child: TextFormField(
                //       style: const TextStyle(color: AppTheme.defaultTextColor),
                //       controller: _nameController,
                //       validator: (value) {
                //         if (value!.isEmpty) {
                //           return 'Name cannot be empty';
                //         } else if (value.length < 3) {
                //           return 'Name must be at least 3 characters long.';
                //         }
                //         return null;
                //       },
                //       onChanged: (value) {
                //         setState(() {
                //           _taxNameController.text = value.toUpperCase();
                //         });
                //       },
                //       decoration: InputDecoration(
                //         labelText: 'Name*',
                //         hintText: 'e.g Plumbing Service',
                //         alignLabelWithHint: true,
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10.0)),
                //       ),
                //     ),
                //   ),
                // ),

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
                                'Select Main Categories',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: mainCategories
                            .map(
                              (item) => DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppTheme.defaultTextColor,
                                    ),
                                  )),
                            )
                            .toList(),
                        value: selectedMainCatagoryByAgent,
                        onChanged: (value) {
                          setState(() {
                            selectedMainCatagoryByAgent = value as String;
                            _mainCategoryController.text = mainCategories
                                .firstWhere((mainc) => mainc.id == value)
                                .id!;
                            callCategoriesByMainCat(
                                id: _mainCategoryController.text);
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

                // Expanded(
                //   child: Container(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.grey,
                //           width: 1.0,
                //         ),
                //         borderRadius: BorderRadius.circular(4.0),
                //       ),
                //       child: MultiSelectDialogField(
                //         buttonText: const Text('Select Main Categories'),
                //         items: mainCategories
                //             .map((e) => MultiSelectItem(e, e.name.toString()))
                //             .toList(),
                //         listType: MultiSelectListType.CHIP,
                //         onConfirm: (values) {
                //           for (var e in values) {
                //             selectedMainCatagoryByAgent.add(e.id.toString());
                //           }
                //         },
                //       ),
                //     ),
                //   ),
                // ),

                // isLoading
                //     ? Expanded(
                //         child: Center(
                //         child: CircularProgressIndicator(color: AppTheme.main),
                //       ))
                //     : const Text(''),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: MultiSelectDialogField(
                        validator: (value) {
                          if (selectedCatagoryByAgent.isEmpty) {
                            return 'Select a category';
                          }
                          return null;
                        },
                        buttonText: const Text('Select SubCategories'),
                        items: categories
                            .where((cat) => cat.status == 1)
                            .map((e) => MultiSelectItem(e, e.name.toString()))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          for (var e in values) {
                            selectedCatagoryByAgent.add(e.id.toString());
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: const EdgeInsets.all(15.0),
            //         child: DropdownButtonHideUnderline(
            //           child: DropdownButton2(
            //             isExpanded: true,
            //             hint: Row(
            //               children: const [
            //                 Icon(
            //                   Icons.list,
            //                 ),
            //                 SizedBox(
            //                   width: 4,
            //                 ),
            //                 Expanded(
            //                   child: Text(
            //                     'Select Provider',
            //                     overflow: TextOverflow.ellipsis,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             items: taskers
            //                 .map(
            //                   (item) => DropdownMenuItem<String>(
            //                     value: item.id,
            //                     child: item.name != null
            //                         ? Text(
            //                             item.name!,
            //                             overflow: TextOverflow.ellipsis,
            //                             style: const TextStyle(
            //                               color: AppTheme.defaultTextColor,
            //                             ),
            //                           )
            //                         : Text(
            //                             item.username!,
            //                             overflow: TextOverflow.ellipsis,
            //                             style: const TextStyle(
            //                               color: AppTheme.defaultTextColor,
            //                             ),
            //                           ),
            //                   ),
            //                 )
            //                 .toList(),
            //             value: selectedTaskerValue,
            //             onChanged: (value) {
            //               setState(() {
            //                 selectedTaskerValue = value as String;
            //                 _taskerController.text = taskers
            //                     .firstWhere((tasker) => tasker.id == value)
            //                     .id!;
            //               });
            //             },
            //             buttonStyleData: getProperty.buttonStyleMethod(),
            //             iconStyleData: getProperty.iconStyleMethod(),
            //             dropdownStyleData:
            //                 getProperty.dropDownStyleDataMethod(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _serviceproviderId,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Service Provider id cannot be empty';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isSent = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Service Provider Id*',
                        hintText: 'click on the search icon to check',
                        suffixIcon: InkWell(
                          onTap: () {
                            if (_serviceproviderId.text.isEmpty) {
                              return;
                            } else {
                              callGetProviderById(id: _serviceproviderId.text);
                            }
                          },
                          child: const Icon(Icons.search),
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator(color: AppTheme.main),
                        )
                      : isSent
                          ? taskers != null
                              ? Card(
                                  color: Colors.amber[
                                      50], // Set your desired background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the radius as needed
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // Display profile image here
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                '${ApiEndPoint.getProviderImage}/${taskers!.avatar}',
                                              ),
                                              radius:
                                                  30, // Adjust the radius as needed
                                            ),
                                            // Display taskers name here
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                taskers!.name.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Display phone number below the name
                                        // Text(
                                        //   taskers!.email.toString(),
                                        //   style: const TextStyle(fontSize: 16),
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              : const Text('Provider Not Found')
                          : const Text(''),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
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

  Widget get newSubCategoryHeader {
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
              RouteService.subCategories(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.subCategories(context);
            },
            child: Text(
              "New Service",
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

  Row buildDropDownRow(Category cat) {
    return Row(
      children: <Widget>[
        Text(cat.name ?? "Select Category"),
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

  void setMainCategories(MainCategoryFactory fnm) {
    pages = fnm.totalPages;
    page = fnm.currentPage;
    setState(() {
      mainCategories = fnm.categories;
    });
  }

  void setTaskers(ServiceProviderFactory fnp) {
    setState(() {
      taskers = fnp.provider;
    });
  }

  save(ctx) async {
    SharedPref sharedPref = SharedPref();
    var agentNumber = await sharedPref.read('storedAdmin');
    if (selectedCatagoryByAgent.isEmpty) {
      snackBarErr(ctx, 'Choose Sub Categories to add to service');
      return;
    }

    if (taskers == null) {
      snackBarErr(ctx, 'Search for a valid provider before saving');
      return;
    }

    if (_serviceproviderId.text != taskers!.taskerNumber.toString()) {
      snackBarErr(ctx, 'Type in the valid id of the Service provider');
      return;
    }

    if (_formKeyCreateSubCategory.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
        getProperty.isInvisible = true;
      });
      // ignore: use_build_context_synchronously
      await Provider.of<ServiceFactory>(context, listen: false).createService(
          taskers!.id.toString(),
          selectedCatagoryByAgent,
          _nameController.text,
          agentNumber);
      // "description": "if empty,category description is used",

      setState(() {
        getProperty.isLoading = false;
        getProperty.isInvisible = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      _serviceproviderId.clear();
      selectedCatagoryByAgent.clear();
      _nameController.clear();
      _mainCategoryController.clear();
      isSent = false;
    } else {
      snackBarError(ctx, _formKeyCreateSubCategory);
      selectedCatagoryByAgent.clear();
    }
  }
}
