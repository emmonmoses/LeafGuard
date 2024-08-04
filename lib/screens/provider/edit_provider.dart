// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables, non_constant_identifier_names
// Flutter imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/address/address.dart';
import 'package:leafguard/models/dob/dob.dart';
import 'package:leafguard/models/location/location.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/profileDetails/profile.dart';
import 'package:leafguard/models/provider/provider_create_return.dart';
import 'package:leafguard/models/provider/provider_update.dart';
import 'package:leafguard/models/provider/skillattachments.dart';
import 'package:leafguard/services/experience/experienceFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

import 'package:http/http.dart' as http;

// Package Imports
import 'package:provider/provider.dart';

class EditProvider extends StatefulWidget {
  final String userId;

  const EditProvider({super.key, required this.userId});

  @override
  State<EditProvider> createState() => _EditProviderState();
}

class _EditProviderState extends State<EditProvider> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _dialingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pictureController = TextEditingController();
  final _pictureController2 = TextEditingController();
  final _availabiltyController = TextEditingController();
  final _experienceController = TextEditingController();
  final _documentController = TextEditingController();
  final _documentTypeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int userStatus = 0;
  int userValue = 0;

  DateTime today = DateTime.now();
  String profilePic = '';
  String key = 'storedToken';
  double? latitude, longitude;

  String dropdownValue = 'Select DocumentType';
  PlatformFile? objFileDoc;
  var attachmentNameDoc, attachmentSizeDoc, attachmentStreamDoc;

  String? imageName;
  DateTime? createdAt, updatedAt;
  final baseUrl = ApiEndPoint.getProviderImage;

  Phone phone = Phone();
  PlatformFile? objFile;
  ProviderCreateReturn userObject = ProviderCreateReturn();
  Address address = Address();

  List<Location> coordinates = [];
  SharedPref sharedPref = SharedPref();
  VariableService getProperty = VariableService();

  List<TextEditingController> answersController = [];

  void generateTextControllers(qns) {
    for (int i = 0; i < qns.length; i++) {
      answersController.add(TextEditingController());
    }
  }

  int _currentStep = 0;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  ProfileDetails? profile;

  List<ProfileDetails> profile_Details = [];

  var attachmentName, attachmentSize, attachmentStream;
  var attachmentNameAvatar, attachmentSizeAvatar, attachmentStreamAvatar;
  PlatformFile? objFileAvatar;

  @override
  void initState() {
    super.initState();
    getProperty.isLoading = true;
    getProperty.isInvisible = true;
    loadData();
    // getProperty.loadData(context);
  }

  loadEX() async {
    ExperienceFactory fne =
        Provider.of<ExperienceFactory>(context, listen: false);

    await fne
        .getAllExperiences(getProperty.search.page)
        .then((r) => {setExperienceVariables(fne)});
  }

  void setExperienceVariables(ExperienceFactory fne) {
    getProperty.pages = fne.totalPages;
    getProperty.page = fne.currentPage;
    getProperty.experiences = fne.experiences;
    getProperty.filteredexperiences = getProperty.experiences;
  }

  @override
  void didChangeDependencies() {
    loadEX();

    super.didChangeDependencies();
  }

  loadData() async {
    userObject =
        await Provider.of<ServiceProviderFactory>(context, listen: false)
            .getUserById(widget.userId);

    _nameController.text = userObject.name!;
    _emailController.text = userObject.email!;
    _usernameController.text = userObject.username!;
    _experienceController.text = userObject.experience.toString();
    _availabiltyController.text = userObject.availability_address.toString();
    _dialingController.text = userObject.phone!.code!;
    _phoneController.text = userObject.phone!.number.toString();
    _pictureController.text = userObject.avatar!;

    _documentController.text =
        userObject.document != null ? userObject.document! : "";
    _documentTypeController.text =
        userObject.documentType != null ? userObject.documentType! : "";

    dropdownValue = userObject.documentType != null
        ? userObject.documentType!
        : "Select DocumentType";

    var g = userObject.gender.toString();
    _genderController.text = userObject.gender.toString();

    if (g == "Male") {
      getProperty.isMaleSelected = true;
      getProperty.isFemaleSelected = false;
    } else {
      getProperty.isMaleSelected = false;
      getProperty.isFemaleSelected = true;
    }

    userStatus = userObject.status!;

    if (userStatus == 1) {
      getProperty.providerStatus = 1;
      getProperty.isActive = true;
    } else {
      getProperty.providerStatus = 0;
      getProperty.isActive = false;
    }

    selectedDate = DateTime(userObject.birthdate!.year as int,
        userObject.birthdate!.month as int, userObject.birthdate!.date as int);
    profilePic = ApiEndPoint.appLogo;
    if (userObject.attachments!.isEmpty) {
      _pictureController2.text = "";
    } else {
      _pictureController2.text = userObject.attachments![0].name.toString();
    }

    // generateTextControllers(userObject.profile_details);

    // for (int i = 0; i < userObject.profile_details!.length; i++) {
    //   answersController[i].text =
    //       userObject.profile_details![i].answer.toString();
    // }

    setState(() {
      selectedDate = DateTime(
          userObject.birthdate!.year as int,
          userObject.birthdate!.month as int,
          userObject.birthdate!.date as int);
      getProperty.isLoading = false;
      getProperty.isInvisible = false;
    });
  }

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    // GlobalKey<FormState>(),
    // GlobalKey<FormState>(),
  ];

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
          Theme(
            data: AppTheme.theming(context),
            child: Stepper(
              elevation: 0,
              controlsBuilder: getProperty.controlBuilders,
              type: StepperType.vertical,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              steps: [
                Step(
                  title: Text(
                    'Personal Information',
                    style: TextStyle(
                      color: getProperty.currentStep == 0
                          ? AppTheme.main
                          : AppTheme.grey,
                    ),
                  ),
                  content: Form(
                    key: _formKeys[0],
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Full Name cannot be empty';
                                    } else if (value.length < 3) {
                                      return 'Full name must be at least 7 characters long.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Full Name*',
                                    hintText: 'e.g Your name',
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Username cannot be empty';
                                    } else if (value.length < 3) {
                                      return 'Username must be at least 3 characters long.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Username*',
                                    hintText: 'e.g jdoe@doe.com',
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  readOnly: false,
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email cannot be empty';
                                    } else if (value.length < 4) {
                                      return 'Email must be at least 4 characters long.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email Address*',
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      getProperty.dropdownGender,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            getProperty.isMaleSelected = true;
                                            getProperty.isFemaleSelected =
                                                false;
                                            _genderController.text = "Male";
                                          });
                                        },
                                        icon: const Icon(Icons.male),
                                        label: const Text('Male'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              getProperty.isMaleSelected
                                                  ? AppTheme.main
                                                  : AppTheme.defaultTextColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            getProperty.isMaleSelected = false;
                                            getProperty.isFemaleSelected = true;
                                            _genderController.text = "Female";
                                          });
                                        },
                                        icon: const Icon(Icons.female),
                                        label: const Text('Female'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              getProperty.isFemaleSelected
                                                  ? AppTheme.main
                                                  : AppTheme.defaultTextColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Expanded(
                            //   child: Container(
                            //     padding: const EdgeInsets.only(
                            //         top: 25.0, right: 15.0, bottom: 15.0),
                            //     child: IntlPhoneField(
                            //       style: const TextStyle(
                            //         color: AppTheme.defaultTextColor,
                            //       ),
                            //       controller: _phoneController,
                            //       validator: (PhoneNumber? value) {
                            //         if (value == null) {
                            //           return 'Phone number cannot be empty';
                            //         }
                            //         return null;
                            //       },
                            //       decoration: const InputDecoration(
                            //         labelText: 'Phone Number*',
                            //         border: OutlineInputBorder(
                            //           borderSide: BorderSide(),
                            //         ),
                            //         alignLabelWithHint: true,
                            //       ),
                            //       initialCountryCode: 'ET',
                            //       onChanged: (phone) {
                            //         setState(() {
                            //           _dialingController.text =
                            //               phone.completeNumber;
                            //           _phoneController.text = phone.number;
                            //           // _availabiltyController.text =
                            //           //     phone.countryISOCode;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  controller: _dialingController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Dialing Code',
                                    hintText: 'e.g +251',
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  controller: _phoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Phone number cannot be empty';
                                    }
                                    if (value.length > 9) {
                                      return 'Enter a valid Number';
                                    }

                                    if (value.length < 9) {
                                      return 'Enter a valid Number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Phone*',
                                    hintText: 'e.g 902000111',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Address cannot be empty';
                                    } else if (value.isEmpty) {
                                      return 'Address must be field.';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  keyboardType: TextInputType.text,
                                  controller: _availabiltyController,
                                  // readOnly: false,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    hintText: 'e.g Jijiga',
                                    hintStyle: TextStyle(
                                      color: AppTheme.grey,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.pin_drop,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: "${selectedDate.toLocal()}"
                                        .split(' ')[0],
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor: AppTheme.main,
                                              dialogBackgroundColor:
                                                  AppTheme.white,
                                              colorScheme:
                                                  ColorScheme.fromSwatch()
                                                      .copyWith(
                                                          secondary:
                                                              AppTheme.main),
                                            ),
                                            child: child!);
                                      },
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null &&
                                        pickedDate != selectedDate) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    suffixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: AppTheme.main, width: 2.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 12.0),
                                    hintText: 'Select a date',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
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
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: <String>[
                                    'Select DocumentType',
                                    'Driving License',
                                    'National ID',
                                    'Passport',
                                    'Kebele ID',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      enabled: value != 'Select DocumentType',
                                      child: value == 'Select DocumentType'
                                          ? Text(
                                              value,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                              ),
                                            )
                                          : Text(
                                              value,
                                              style: const TextStyle(
                                                color:
                                                    AppTheme.defaultTextColor,
                                              ),
                                            ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      if (dropdownValue !=
                                          'Select DocumentType') {
                                        _documentTypeController.text =
                                            dropdownValue;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0,
                                ),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (_documentTypeController.text !=
                                        'Select DocumentType') {
                                      if (value!.isEmpty) {
                                        return 'Documents of the Provider is Mandatory';
                                      }
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _documentController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Click the icon on the right to upload document ',
                                    hintText: 'Document',
                                    hintStyle: TextStyle(
                                      color: AppTheme.grey,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.camera,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        chooseFileDocument();
                                      },
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                // Step(
                //   title: Text(
                //     'Security',
                //     style: TextStyle(
                //       color: getProperty.currentStep == 1
                //           ? AppTheme.main
                //           : AppTheme.grey,
                //     ),
                //   ),
                //   content: Form(
                //     key: _formKeys[1],
                //     child: Row(
                //       children: [
                //         // Expanded(
                //         //   child: Container(
                //         //     padding: const EdgeInsets.only(
                //         //       right: 15.0,
                //         //       bottom: 15.0,
                //         //     ),
                //         //     child: TextFormField(
                //         //       style: const TextStyle(
                //         //           color: AppTheme.defaultTextColor),
                //         //       controller: _passwordController,
                //         //       decoration: InputDecoration(
                //         //         labelText: 'Password',
                //         //         hintText: 'e.g jD&moh@1',
                //         //         alignLabelWithHint: true,
                //         //         border: OutlineInputBorder(
                //         //             borderRadius: BorderRadius.circular(10.0)),
                //         //       ),
                //         //     ),
                //         //   ),
                //         // ),

                //         Expanded(
                //           child: Container(
                //             padding: const EdgeInsets.only(
                //               right: 15.0,
                //               bottom: 15.0,
                //             ),
                //             child: SwitchListTile(
                //               title: const Text(
                //                 'Status',
                //                 style: TextStyle(
                //                   color: AppTheme.defaultTextColor,
                //                 ),
                //               ),
                //               subtitle: !getProperty.isActive
                //                   ? Text(
                //                       'In Active',
                //                       style: TextStyle(
                //                         color: getProperty.providerStatus == 1
                //                             ? AppTheme.main
                //                             : AppTheme.defaultTextColor,
                //                       ),
                //                     )
                //                   : Text(
                //                       'Active',
                //                       style: TextStyle(
                //                         color: getProperty.providerStatus == 1
                //                             ? AppTheme.main
                //                             : AppTheme.defaultTextColor,
                //                       ),
                //                     ),
                //               activeColor: AppTheme.main,
                //               inactiveThumbColor: Colors.black,
                //               inactiveTrackColor: Colors.blueGrey,
                //               value: getProperty.providerStatus == 0
                //                   ? false
                //                   : true,
                //               onChanged: (bool value) {
                //                 setState(() {
                //                   getProperty.providerStatus == 0
                //                       ? false
                //                       : true;
                //                   if (value) {
                //                     getProperty.providerStatus = 1;
                //                     getProperty.isActive = value;
                //                   } else {
                //                     getProperty.providerStatus = 0;
                //                     getProperty.isActive = value;
                //                   }
                //                 });
                //               },
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   isActive: _currentStep >= 1,
                //   state: _currentStep >= 1
                //       ? StepState.complete
                //       : StepState.disabled,
                // ),

                // Step(
                //   title: Text(
                //     'Questionnaire',
                //     style: TextStyle(
                //       color: getProperty.currentStep == 2
                //           ? AppTheme.main
                //           : AppTheme.grey,
                //     ),
                //   ),
                //   content: Form(
                //     key: _formKeys[2],
                //     child: Column(
                //       children: [
                //         ListView.separated(
                //           shrinkWrap: true,
                //           itemCount: userObject.profile_details!.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             return ListTile(
                //               title: Row(
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(right: 8.0),
                //                     child: Text(
                //                       '${index + 1}.'.toString(),
                //                       style: const TextStyle(
                //                         color: AppTheme.defaultTextColor,
                //                       ),
                //                     ),
                //                   ),
                //                   Text(
                //                     // getProperty
                //                     //     .filteredQuestions[index].question!,
                //                     userObject
                //                         .profile_details![index].question!,
                //                     style: const TextStyle(
                //                       color: AppTheme.defaultTextColor,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               subtitle: TextField(
                //                 style: const TextStyle(
                //                   color: AppTheme.defaultTextColor,
                //                 ),
                //                 controller: answersController[index],
                //                 maxLines: 3,
                //                 decoration: InputDecoration(
                //                   labelText: 'Answer Q(${index + 1})',
                //                 ),
                //                 onChanged: (value) {
                //                   String answer = value;
                //                   profile = ProfileDetails(
                //                       question:
                //                           //  getProperty
                //                           //     .filteredQuestions[index].id,
                //                           // answer: answersController[index]
                //                           //     .text,
                //                           userObject
                //                               .profile_details![index].question,
                //                       answer: answer);
                //                 },
                //               ),
                //             );
                //           },
                //           separatorBuilder: (BuildContext context, int index) {
                //             return const Text('');
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                //   isActive: _currentStep >= 2,
                //   state: _currentStep >= 2
                //       ? StepState.complete
                //       : StepState.disabled,
                // ),

                Step(
                  title: Text(
                    'Add Skills',
                    style: TextStyle(
                      color: getProperty.currentStep == 1
                          ? AppTheme.main
                          : AppTheme.grey,
                    ),
                  ),
                  content: Form(
                    key: _formKeys[1],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 15.0),
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
                                      'Select Experience *',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: getProperty.experiences
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
                              value: getProperty.selectedExperienceValue,
                              onChanged: (value) {
                                setState(() {
                                  getProperty.selectedExperienceValue =
                                      value as String;
                                  _experienceController.text = getProperty
                                      .experiences
                                      .firstWhere((experience) =>
                                          experience.id == value)
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
                        if (getProperty.selectedExperienceValue != null &&
                            (getProperty.experiences
                                    .firstWhere((experience) =>
                                        experience.id ==
                                        getProperty.selectedExperienceValue!)
                                    .name!
                                    .startsWith("sk".toLowerCase()) ||
                                getProperty.experiences
                                    .firstWhere((experience) =>
                                        experience.id ==
                                        getProperty.selectedExperienceValue!)
                                    .name!
                                    .startsWith("Sk")))
                          Row(
                            children: [
                              // Text('Upload Skill Verification Document')
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: AppTheme.defaultTextColor),
                                    keyboardType: TextInputType.text,
                                    controller: _pictureController2,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText:
                                          'Click the icon on the right to upload file(s)',
                                      hintText: 'Verification Document',
                                      hintStyle: TextStyle(
                                        color: AppTheme.grey,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.camera,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          chooseFile();
                                        },
                                      ),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 1,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
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
    );
  }

  continueStep() {
    // if (_formKeyCreateTasker.currentState!.validate()) {
    // if (getProperty.currentStep < 4) {
    //   setState(() {
    //     getProperty.currentStep += 1;
    //   });
    // }
    if (_documentTypeController.text.isEmpty) {
      snackBarErr(context, 'Document Type is required');
      return;
    }
    if (_formKeys[_currentStep].currentState!.validate()) {
      _currentStep < 1 ? setState(() => _currentStep += 1) : update(context);
    }
    // } else {
    //   snackBarValidation();
    // }
  }

  cancelStep() {
    // if (getProperty.currentStep > 0) {
    //   setState(() {
    //     getProperty.currentStep -= 1;
    //   });
    // }

    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  onStepTapped(int value) {
    setState(() {
      getProperty.currentStep = value;
    });
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
              RouteService.taskers(context);
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
              "Edit Provider ",
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
                    onTap: () {
                      update(context);
                    },
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
      _pictureController2.text = attachmentName.toString();
    }
  }

  uploadFile() async {
    String postUrl = "${ApiEndPoint.endpoint}/taskers/attachment";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "attachments",
      attachmentStream,
      attachmentSize,
      filename: attachmentName,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => toastError(err));
  }

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
    String postUrl = "${ApiEndPoint.endpoint}/taskers/upload";

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

  addToProfileDetails() {
    for (var i = 0; i < userObject.profile_details!.length; i++) {
      profile = ProfileDetails(
        question: userObject.profile_details![i].question,
        answer: answersController[i].text,
      );

      setState(() {
        profile_Details.add(profile!);
      });
    }
  }

  update(ctx) async {
    if (_documentTypeController.text.isEmpty) {
      snackBarErr(ctx, 'Document Type is required');
      return;
    }
    if (_documentController.text.isEmpty) {
      snackBarErr(ctx, 'Upload Document is required');
      return;
    }
    setState(() {
      getProperty.isLoading = true;
      getProperty.isInvisible = true;
    });

    var birthdate = BirthDate(
      date: selectedDate.day,
      month: selectedDate.month,
      year: selectedDate.year,
    );

    Phone ph = Phone(
      code: _dialingController.text,
      number: _phoneController.text,
    );

    List<Skillattachments> skillattachments = [];

    if (getProperty.selectedExperienceValue != null &&
        (getProperty.experiences
                .firstWhere((experience) =>
                    experience.id == getProperty.selectedExperienceValue!)
                .name!
                .startsWith("sk".toLowerCase()) ||
            getProperty.experiences
                .firstWhere((experience) =>
                    experience.id == getProperty.selectedExperienceValue!)
                .name!
                .startsWith("Sk"))) {
      skillattachments.add(
        Skillattachments(
          name: _pictureController2.text.toString(),
        ),
      );
    }

    ProviderUpdate updateProvider = ProviderUpdate(
      id: widget.userId,
      name: _nameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      experienceId: _experienceController.text,
      avatar: _pictureController.text.toString(),
      birthdate: birthdate,
      status: getProperty.providerStatus,
      phone: ph,
      availability_address: _availabiltyController.text,
      skillattachments: skillattachments,
      taskerStatus: userObject.taskerStatus,
      gender: _genderController.text,
      profile_details: userObject.profile_details,
      document: _documentController.text,
      documentType: _documentTypeController.text,
      createdBy: userObject.createdBy,
    );

    // return;

    await Provider.of<ServiceProviderFactory>(context, listen: false)
        .updateServiceProvider(updateProvider);

    if (_pictureController.text != userObject.avatar.toString()) {
      await uploadFileAvatar();
    }

    if (_documentController.text != userObject.document) {
      await uploadFileDocument();
    }

    if (userObject.attachments!.isNotEmpty) {
      if (_pictureController2.text !=
          userObject.attachments![0].name.toString()) {
        await uploadFile();
      }
    }

    setState(() {
      getProperty.isLoading = false;
      getProperty.isInvisible = false;
    });

    snackBarNotification(ctx, ToasterService.successMsg);
    RouteService.taskers(ctx);
  }

  chooseFileDocument() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFileDoc = result.files.single;
        attachmentNameDoc = objFileDoc!.name;
        attachmentStreamDoc = objFileDoc!.readStream;
        attachmentSizeDoc = objFileDoc!.size;
      });
      _documentController.text = attachmentName;
    }
  }

  uploadFileDocument() async {
    String postUrl = "${ApiEndPoint.endpoint}/taskers/attachment";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    request.files.add(http.MultipartFile(
      "attachments",
      attachmentStreamDoc,
      attachmentSizeDoc,
      filename: attachmentNameDoc,
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
