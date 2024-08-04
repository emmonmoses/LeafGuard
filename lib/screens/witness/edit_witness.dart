// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/address/address_witness.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/witness/witness.dart';
import 'package:leafguard/models/witness/witness_update.dart';
import 'package:leafguard/models/witness/witnessresponse.dart';
import 'package:leafguard/screens/provider/home.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:leafguard/services/sharedpref_service.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;

import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditWitness extends StatefulWidget {
  static const routeName = '/witnessupdate';

  final WitnessResponse witness;
  final ServiceProvider provider;

  const EditWitness({super.key, required this.witness, required this.provider});

  @override
  State<EditWitness> createState() => _EditWitnessState();
}

class _EditWitnessState extends State<EditWitness> {
  late GlobalKey<FormState> _formKeyUpdateWitnesses;

  final _taskerController = TextEditingController();
  final _nameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _documentController = TextEditingController();
  final _lineController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();

  final _nameController2 = TextEditingController();
  final _nationalIdController2 = TextEditingController();
  final _phoneController2 = TextEditingController();
  final _documentController2 = TextEditingController();
  final _lineController2 = TextEditingController();
  final _stateController2 = TextEditingController();
  final _countryController2 = TextEditingController();
  final _cityController2 = TextEditingController();

  VariableService getProperty = VariableService();
  WitnessResponse updatedWitness = WitnessResponse();

  var attachmentName1, attachmentSize1, attachmentStream1;
  var attachmentName2, attachmentSize2, attachmentStream2;

  PlatformFile? objFile2;
  PlatformFile? objFile1;

  var accessToken = '';
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    // getProperty.loadData(context);

    _formKeyUpdateWitnesses = GlobalKey();
  }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _nationalIdController.dispose();
  //   _phoneController.dispose();
  //   _documentController.dispose();
  //   super.dispose();
  // }

  @override
  void didChangeDependencies() {
    getProperty.loadData(context);

    if (getProperty.isInit) {
      updatedWitness = widget.witness;

      _taskerController.text = updatedWitness.taskerId!;

      _nameController.text = updatedWitness.witnesses![0].name!;
      _nationalIdController.text = updatedWitness.witnesses![0].nationalId!;
      _phoneController.text = updatedWitness.witnesses![0].phone!;
      _documentController.text = updatedWitness.witnesses![0].document!;
      _cityController.text = updatedWitness.witnesses![0].address?.city ?? '';
      _countryController.text =
          updatedWitness.witnesses![0].address?.country ?? '';
      _stateController.text = updatedWitness.witnesses![0].address?.state ?? "";
      _lineController.text = updatedWitness.witnesses![0].address?.line ?? "";

      _nameController2.text = updatedWitness.witnesses![1].name!;
      _nationalIdController2.text = updatedWitness.witnesses![1].nationalId!;
      _phoneController2.text = updatedWitness.witnesses![1].phone!;
      _documentController2.text = updatedWitness.witnesses![1].document!;
      _cityController2.text = updatedWitness.witnesses![1].address?.city ?? '';
      _countryController2.text =
          updatedWitness.witnesses![1].address?.country ?? '';
      _stateController2.text =
          updatedWitness.witnesses![1].address?.state ?? '';
      _lineController2.text = updatedWitness.witnesses![1].address?.line ?? '';
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
        key: _formKeyUpdateWitnesses,
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
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Card(
                        color: Colors
                            .amber[50], // Set your desired background color
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
                                      '${ApiEndPoint.getProviderImage}/${widget.provider.avatar}',
                                    ),
                                    radius: 30, // Adjust the radius as needed
                                  ),
                                  // Display taskers name here
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.provider.name.toString(),
                                      style: const TextStyle(fontSize: 18),
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
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButton2(
                      //     isExpanded: true,
                      //     hint: Row(
                      //       children: const [
                      //         Icon(
                      //           Icons.list,
                      //         ),
                      //         SizedBox(
                      //           width: 4,
                      //         ),
                      //         Expanded(
                      //           child: Text(
                      //             'Select Provider*',
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     items: getProperty.taskers
                      //         .map(
                      //           (item) => DropdownMenuItem<String>(
                      //             value: item.id,
                      //             child: Text(
                      //               item.name!.toUpperCase(),
                      //               overflow: TextOverflow.ellipsis,
                      //               style: const TextStyle(
                      //                 color: AppTheme.defaultTextColor,
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //         .toList(),
                      //     value: getProperty.selectedProviderValue,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         getProperty.selectedProviderValue = value as String;
                      //         _taskerController.text = getProperty.taskers
                      //             .firstWhere((tasker) => tasker.id == value)
                      //             .id!;
                      //       });
                      //     },
                      //     buttonStyleData: getProperty.buttonStyleMethod(),
                      //     iconStyleData: getProperty.iconStyleMethod(),
                      //     dropdownStyleData:
                      //         getProperty.dropDownStyleDataMethod(),
                      //   ),
                      // ),
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
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Fullname*',
                        hintText: 'e.g Aisha Mohammed',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 25.0, right: 15.0, bottom: 15.0),
                    child: IntlPhoneField(
                      style: const TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                      validator: (PhoneNumber? value) {
                        if (value == null) {
                          return 'Phone number cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: _phoneController.text.isEmpty
                            ? updatedWitness.witnesses![0].phone!
                            : _phoneController.text,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        alignLabelWithHint: true,
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        setState(() {
                          _phoneController.text =
                              phone.countryCode + phone.number;
                          if (phone.number.isEmpty) {
                            _phoneController.text =
                                updatedWitness.witnesses![0].phone!;
                          }
                        });
                      },
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
                      controller: _nationalIdController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Identification number cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'ID or Passport or License Number*',
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
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      keyboardType: TextInputType.text,
                      controller: _documentController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            'Click the icon on the right to upload your document*',
                        hintText: 'ID or Passport or License Picture',
                        hintStyle: TextStyle(
                          color: AppTheme.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.camera,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // chooseFile();
                            chooseFileWitness1();
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
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _lineController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address  is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Address *',
                        hintText: 'e.g postal address,mailing addres',
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
                      controller: _stateController,
                      //  validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'State  is required';
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                        labelText: 'State',
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
                            exclude: <String>['KP'],
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
                          return 'City is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'City*',
                        hintText: 'e.g Addis Ababa',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5.0),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
              child: Text(
                'Witness 2'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _nameController2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Fullname*',
                        hintText: 'e.g Aisha Mohammed',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 25.0, right: 15.0, bottom: 15.0),
                    child: IntlPhoneField(
                      style: const TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                      validator: (PhoneNumber? value) {
                        if (value == null) {
                          return 'Phone number cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: _phoneController2.text.isEmpty
                            ? updatedWitness.witnesses![1].phone!
                            : _phoneController2.text,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        alignLabelWithHint: true,
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        setState(() {
                          _phoneController2.text =
                              phone.countryCode + phone.number;
                          if (phone.number.isEmpty) {
                            _phoneController2.text =
                                updatedWitness.witnesses![1].phone!;
                          }
                        });
                      },
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
                      controller: _nationalIdController2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Identification number cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'ID or Passport or License Number*',
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
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      keyboardType: TextInputType.text,
                      controller: _documentController2,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            'Click the icon on the right to upload your document*',
                        hintText: 'ID or Passport or License Picture',
                        hintStyle: TextStyle(
                          color: AppTheme.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.camera,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // chooseFile();
                            chooseFileWitness2();
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
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _lineController2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address  is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Address *',
                        hintText: 'e.g postal address,mailing addres',
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
                      controller: _stateController2,
                      decoration: InputDecoration(
                        labelText: 'State',
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
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _countryController2,
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
                            exclude: <String>['KP'],
                            onSelect: (Country country) {
                              _countryController2.text = country.name;
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
                      controller: _cityController2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'City is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'City*',
                        hintText: 'e.g Addis Ababa',
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
                  pageBuilder: (_, __, ___) => const ProviderHome(),
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
              RouteService.taskers(context);
            },
            child: Text(
              "Edit Witness",
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
                      RouteService.taskers(context);
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
    if (_phoneController.text.isEmpty || _phoneController2.text.isEmpty) {
      snackBarErr(ctx, 'Witness phone number is required');
      return;
    }
    if (_formKeyUpdateWitnesses.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      WitnessUpdate witnessObject = WitnessUpdate(
        id: widget.witness.id,
        taskerId: _taskerController.text,
        taskerWitnesses: [
          Witness(
            name: _nameController.text,
            nationalId: _nationalIdController.text,
            phone: _phoneController.text,
            document: _documentController.text,
            address: AddressWitness(
              line: _lineController.text,
              city: _cityController.text,
              country: _countryController.text,
              state: _stateController.text,
            ),
          ),
          Witness(
            name: _nameController2.text,
            nationalId: _nationalIdController2.text,
            phone: _phoneController2.text,
            document: _documentController2.text,
            address: AddressWitness(
              line: _lineController2.text,
              city: _cityController2.text,
              country: _countryController2.text,
              state: _stateController2.text,
            ),
          ),
        ],
      );
      await Provider.of<WitnessFactory>(context, listen: false)
          .updateWitness(witnessObject);

      if (_documentController.text != updatedWitness.witnesses![0].document!) {
        await uploadFilewitness1();
      }

      if (_documentController2.text != updatedWitness.witnesses![1].document!) {
        await uploadFileWitness2();
      }
      setState(() {
        getProperty.isLoading = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateWitnesses);
    }
  }

  goBack() {
    RouteService.taskers(context);
  }

  chooseFileWitness1() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile1 = result.files.single;
        attachmentName1 = objFile1!.name;
        attachmentStream1 = objFile1!.readStream;
        attachmentSize1 = objFile1!.size;
      });
      _documentController.text = attachmentName1;
      // await uploadFile();
    }
  }

  uploadFilewitness1() async {
    String postUrl = "${ApiEndPoint.endpoint}/witness/upload";
    accessToken = await sharedPref.read(key);

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
      "Authorization": "Bearer $accessToken",
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "document",
      attachmentStream1,
      attachmentSize1,
      filename: attachmentName1,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => toastError(err));
  }

  chooseFileWitness2() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile2 = result.files.single;

        attachmentName2 = objFile2!.name;
        attachmentStream2 = objFile2!.readStream;
        attachmentSize2 = objFile2!.size;
      });
      _documentController2.text = attachmentName2;
      // await uploadFile();
    }
  }

  uploadFileWitness2() async {
    String postUrl = "${ApiEndPoint.endpoint}/witness/upload";
    accessToken = await sharedPref.read(key);

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
      "Authorization": "Bearer $accessToken",
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "document",
      attachmentStream2,
      attachmentSize2,
      filename: attachmentName2,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => toastError(err));
  }
}
