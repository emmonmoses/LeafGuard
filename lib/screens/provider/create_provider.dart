// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names
// Project imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/days/days.dart';
import 'package:leafguard/models/dob/dob.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/profileDetails/profile.dart';
import 'package:leafguard/models/provider/skillattachments.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;

import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:http/http.dart' as http;

enum Gender { male, female, other }

class CreateTasker extends StatefulWidget {
  const CreateTasker({Key? key}) : super(key: key);

  @override
  CreateTaskerState createState() => CreateTaskerState();
}

class CreateTaskerState extends State<CreateTasker> {
  // late GlobalKey<FormState> _formKeyCreateTasker;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dialingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pictureController = TextEditingController();
  final _pictureController2 = TextEditingController();
  final _passwordController = TextEditingController();
  final _availabiltyController = TextEditingController();
  final _experienceController = TextEditingController();
  final _genderController = TextEditingController();
  final _documentController = TextEditingController();
  final _documentTypeController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  VariableService getProperty = VariableService();
  late List<bool> checkedList;
  List<Days> daysavailable = [];
  Days availability = Days();
  ProfileDetails? profile;
  String? selectedMainCategory;
  String? selectedSubCategory;
  List<Category>? category = [];
  List<String?> mainCategories = [];
  String mainCatErr = 'Select Main Category';
  String subCatErr = 'Select SubCategories';
  bool hasData = true;
  List<ProfileDetails> profile_Details = [];
  List<String> selectedCatagoryByAdmin = [];
  List<String> allSelectedCatagoryByAdmin = [];

  List<Map<String, String>> diplayAllSelectedCatagoryByAdmin = [];

  String? categoryId;
  List<String?> subCategories = [];
  String dropdownValue = 'Select DocumentType';

  DateTime today = DateTime.now();

  @override
  void initState() {
    getProperty.profilePic = ApiEndPoint.appLogo;
    // checkedList = List.filled(daysOfWeek.length, false);
    getCatagories();

    // _formKeyCreateTasker = GlobalKey();
    super.initState();
  }

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  void didChangeDependencies() {
    getProperty.loadData(context);
    super.didChangeDependencies();
  }

  // @override
  // void dispose() {
  //   _genderController.dispose();
  //   _emailController.dispose();
  //   _usernameController.dispose();
  //   _passwordController.dispose();
  //   _passwordController.dispose();
  //   _birthYearController.dispose();
  //   _birthMonthController.dispose();
  //   _birthDateController.dispose();
  //   _availabiltyController.dispose();
  //   _nameController.dispose();
  //   // _radiusController.dispose();
  //   _dialingController.dispose();
  //   _phoneController.dispose();
  //   _pictureController.dispose();
  //   _categoryController.dispose();
  //   _serviceController.dispose();
  //   _priceRateController.dispose();
  //   _rateTypeController.dispose();
  //   _experienceController.dispose();
  //   super.dispose();
  // }

  DateTime selectedDate = DateTime.now();
  var attachmentName, attachmentSize, attachmentStream;
  var attachmentNameAvatar, attachmentSizeAvatar, attachmentStreamAvatar;
  var attachmentNameDoc, attachmentSizeDoc, attachmentStreamDoc;

  PlatformFile? objFileAvatar;
  PlatformFile? objFile;
  PlatformFile? objFileDoc;

  int _currentStep = 0;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  getCatagories() async {
    var result = await Provider.of<MainCategoryFactory>(context, listen: false)
        .getAllMainCategories(1);
    setState(() {
      mainCategories = result!.map((e) => e.name).toList();
    });
  }

  getCategoryId() async {
    var cats =
        Provider.of<MainCategoryFactory>(context, listen: false).categories;
    var res = cats.firstWhere(
      (element) => element.name == selectedMainCategory,
    );

    categoryId = res.id;

    await getServiceByMainCategoryId(categoryId);
  }

  getServiceByMainCategoryId(categoryId) async {
    setState(() {
      hasData = false;
    });

    category = await Provider.of<CategoryFactory>(context, listen: false)
        .getCategoriesByMainCategoryId(categoryId, 1);

    setState(() {
      subCategories = category!.map((e) => e.name).toList();
      hasData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (getProperty.filteredQuestions.isEmpty) {
      getProperty.filteredQuestions = getProperty.questions;
    }

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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildForm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildForm {
    DateTime firstDate = today.subtract(const Duration(days: 365 * 70));
    DateTime lastDate = today.subtract(const Duration(days: 365 * 18));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          newHeader(),
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
              // onStepTapped: onStepTapped,
              currentStep: _currentStep,

              onStepTapped: (step) => tapped(step),
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              // currentStep: getProperty.currentStep,
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
                                      return 'email cannot be empty';
                                    }
                                    if (!value.contains('@')) {
                                      return 'enter a valid email';
                                    }
                                    final parts = value.split('@');
                                    if (parts.length != 2) {
                                      return 'enter a valid email';
                                    }
                                    final localPart = parts[0];
                                    final domainPart = parts[1];

                                    // Validate the local part of the email
                                    if (localPart.isEmpty ||
                                        localPart.length > 64) {
                                      return 'enter a valid email';
                                    }

                                    // Validate the domain part of the email
                                    if (domainPart.isEmpty ||
                                        domainPart.length > 255) {
                                      return 'enter a valid email';
                                    }

                                    // Check if the domain has at least one period (.)
                                    if (!domainPart.contains('.')) {
                                      return 'enter a valid email';
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Choose picture to upload';
                                    }
                                    return null;
                                  },
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
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 25.0, right: 15.0, bottom: 15.0),
                                child: IntlPhoneField(
                                  autovalidateMode: AutovalidateMode.always,
                                  style: const TextStyle(
                                    color: AppTheme.defaultTextColor,
                                  ),
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
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number*',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                  initialCountryCode: 'ET',
                                  onChanged: (phone) {
                                    setState(() {
                                      _dialingController.text =
                                          phone.countryCode;
                                      _phoneController.text = phone.number;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 15.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  keyboardType: TextInputType.text,
                                  controller: _availabiltyController,
                                  // readOnly: false,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Address is required";
                                    }
                                    if (value.length < 3) {
                                      return "Address location should be at least 3 characters";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Address *',
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
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: "${selectedDate.toLocal()}"
                                        .split(' ')[0],
                                  ),
                                  validator: (value) {
                                    if (value ==
                                        "${DateTime.now().toLocal()}"
                                            .split(' ')[0]) {
                                      return "Choose date of Birth";
                                    }
                                    return null;
                                  },
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
                                      initialDate: lastDate,
                                      firstDate: firstDate,
                                      lastDate: lastDate,
                                    );
                                    if (pickedDate != null &&
                                        pickedDate != selectedDate) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Date of Birth',
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
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text(
                    'Security',
                    style: TextStyle(
                      color: getProperty.currentStep == 1
                          ? AppTheme.main
                          : AppTheme.grey,
                    ),
                  ),
                  content: Form(
                    key: _formKeys[1],
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: AppTheme.defaultTextColor),
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'e.g jD&moh@1',
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
                  isActive: _currentStep >= 1,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text(
                    'Questionnaire',
                    style: TextStyle(
                      color: getProperty.currentStep == 2
                          ? AppTheme.main
                          : AppTheme.grey,
                    ),
                  ),
                  content: Form(
                    key: _formKeys[2],
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: getProperty.filteredQuestions
                              .where((element) => element.status == 1)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '${index + 1}.'.toString(),
                                      style: const TextStyle(
                                        color: AppTheme.defaultTextColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getProperty
                                        .filteredQuestions[index].question!,
                                    style: const TextStyle(
                                      color: AppTheme.defaultTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: TextField(
                                style: const TextStyle(
                                  color: AppTheme.defaultTextColor,
                                ),
                                controller:
                                    getProperty.answersController[index],
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: 'Answer Q(${index + 1})',
                                ),
                                onChanged: (value) {
                                  // for (var controller in answersController) {
                                  // getProperty.profile = ProfileDetails(
                                  //   question:
                                  //       getProperty.filteredQuestions[index].id,
                                  //   answer: getProperty
                                  //       .answersController[index].text,
                                  // );

                                  // setState(() {
                                  //   getProperty.profileDetails
                                  //       .add(getProperty.profile);
                                  // });

                                  String answer = value;
                                  profile = ProfileDetails(
                                      question: getProperty
                                          .filteredQuestions[index].id,
                                      // answer: answersController[index]
                                      //     .text,
                                      answer: answer);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Text('');
                          },
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 2,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),

                Step(
                  title: Text(
                    'Add Skills',
                    style: TextStyle(
                      color: getProperty.currentStep == 3
                          ? AppTheme.main
                          : AppTheme.grey,
                    ),
                  ),
                  content: Form(
                    key: _formKeys[3],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
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
                        // if (getProperty.selectedExperienceValue != null &&
                        //     getProperty.selectedExperienceValue!
                        //         .startsWith("Sk".toLowerCase()))
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
                  isActive: _currentStep >= 3,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
                // Step(
                //   title: Text(
                //     'Upload Skill Verification Document(s)',
                //     style: TextStyle(
                //       color: getProperty.currentStep == 4
                //           ? AppTheme.main
                //           : AppTheme.grey,
                //     ),
                //   ),
                //   content:
                //     child:
                //   ),
                //   isActive: _currentStep >= 4,
                //   state: _currentStep >= 4
                //       ? StepState.complete
                //       : StepState.disabled,
                // ),
                Step(
                  title: const Text('Services'),
                  content: Form(
                    key: _formKeys[4],
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            // borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<String>(
                            // borderRadius: BorderRadius.circular(8),
                            isExpanded: true,
                            value: selectedMainCategory,
                            hint: const Text('Select a Main Category'),
                            onChanged: (newValue) async {
                              setState(() {
                                selectedMainCategory = newValue;
                                mainCatErr = "";
                                selectedSubCategory = null;
                              });
                              await getCategoryId();
                            },
                            items: mainCategories.map<DropdownMenuItem<String>>(
                              (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        // if (mainCatErr.isEmpty)
                        //   Text(
                        //     mainCatErr.toString(),
                        //     style: const TextStyle(color: Colors.red),
                        //   ),
                        if (selectedMainCategory != null)
                          hasData
                              ? Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: MultiSelectDialogField(
                                        items: category!
                                            .where((cat) => cat.status == 1)
                                            .map((e) => MultiSelectItem(
                                                e, e.name.toString()))
                                            .toList(),
                                        listType: MultiSelectListType.CHIP,
                                        onConfirm: (values) {
                                          for (var e in values) {
                                            subCatErr = "";
                                            selectedCatagoryByAdmin
                                                .add(e.id.toString());
                                            setState(() {
                                              diplayAllSelectedCatagoryByAdmin
                                                  .add({
                                                'name': e.name.toString(),
                                                'id': e.id.toString()
                                              });

                                              allSelectedCatagoryByAdmin
                                                  .add(e.id.toString());
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator.adaptive()),
                        // if (subCatErr != null)
                        //   Text(
                        //     subCatErr.toString(),
                        //     style: const TextStyle(color: Colors.red),
                        //   ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (diplayAllSelectedCatagoryByAdmin.isNotEmpty)
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: diplayAllSelectedCatagoryByAdmin
                                  .length, // Ensure this is a list of items you want to display
                              itemBuilder: (context, index) {
                                // Example of displaying a text widget for each category
                                return Container(
                                  width: 200,
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          10), // Optional: adds margin around each item
                                  child: ListTile(
                                    title: Text(
                                      diplayAllSelectedCatagoryByAdmin[index]
                                              ['name']
                                          .toString(),
                                    ),
                                    trailing: InkWell(
                                        onTap: () {
                                          setState(() {
                                            diplayAllSelectedCatagoryByAdmin
                                                .remove(
                                              diplayAllSelectedCatagoryByAdmin[
                                                  index],
                                            );
                                          });
                                        },
                                        child: Icon(Icons.remove)),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                // Example of a simple separator
                                return VerticalDivider(
                                  color: Colors.grey, // Separator color
                                  width:
                                      10, // The width space the divider takes
                                );
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 4,
                  state: _currentStep >= 4
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

  Widget newHeader() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              tooltip: 'Menu',
              icon: Icon(
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
              RouteService.taskers(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.taskers(context);
            },
            child: Text(
              "New Provider",
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
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppTheme.main),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      signUp(context);
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

  continueStep() {
    // if (_formKeyCreateTasker.currentState!.validate()) {
    // if (getProperty.currentStep < 4) {
    //   setState(() {
    //     getProperty.currentStep += 1;
    //   });
    // }

    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_genderController.text.isEmpty) {
        snackBarErr(context, 'Gender is required');
        return;
      }

      if (_currentStep < 4) {
        setState(() => _currentStep += 1);
      } else if (_currentStep == 4) {
        if (_formKeys[4].currentState!.validate()) {
          if (mainCatErr.isNotEmpty) {
            snackBarErr(context, 'Select Main Category');
            return;
          }
          if (subCatErr.isNotEmpty) {
            snackBarErr(context, 'Select the SubCategories');
            return;
          }
          signUp(context);
        }
      }

      // _currentStep < 4 ? setState(() => _currentStep += 1) : signUp(context);
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

  clearSearch() {
    searchController.clear();
    getProperty.search.searchText = '';
    setState(() {
      getProperty.filteredQuestions = getProperty.questions;
      getProperty.isInvisible = false;
      getProperty.isVisible = true;
    });
  }

  addToProfileDetails() {
    for (var i = 0;
        i <
            getProperty.filteredQuestions
                .where((element) => element.status == 1)
                .length;
        i++) {
      profile = ProfileDetails(
        question: getProperty.filteredQuestions[i].id,
        answer: getProperty.answersController[i].text,
        // answer: answer
      );

      setState(() {
        profile_Details.add(profile!);
      });
    }
  }

  signUp(ctx) async {
    if (_documentTypeController.text.isEmpty) {
      snackBarErr(ctx, 'Document Type is required');
      return;
    }
    if (_documentController.text.isEmpty) {
      snackBarErr(ctx, 'Upload Document is required');
      return;
    }
    if (mainCatErr.isEmpty && subCatErr.isEmpty) {
      setState(() {
        getProperty.isLoading = true;
        getProperty.isInvisible = true;
      });

      addToProfileDetails();

      List<Skillattachments> skillattachments = [];

      // if (getProperty.selectedExperienceValue!.startsWith("Sk")) {

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
            name: attachmentName.toString(),
            // name: _pictureController2.text.toString(),
          ),
        );
      }
      var birthdate = BirthDate(
        date: selectedDate.day,
        month: selectedDate.month,
        year: selectedDate.year,
      );

      Phone ph = Phone(
        code: _dialingController.text,
        number: _phoneController.text,
      );

      var categoryId =
          diplayAllSelectedCatagoryByAdmin.map((cat) => cat['id']!).toList();

      // return;

      await Provider.of<ServiceProviderFactory>(context, listen: false)
          .createServiceProvider(
        name: _nameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        phone: ph,
        birthdate: birthdate,
        password: _passwordController.text,
        gender: _genderController.text,
        status: 0,
        taskerStatus: 1,
        availabilityAddress: _availabiltyController.text,
        avatar: attachmentNameAvatar.toString(),
        experienceId: _experienceController.text,
        profileDetails: profile_Details,
        skill: skillattachments,
        categoryId: categoryId,
        document: _documentController.text,
        documentType: _documentTypeController.text,
      );

      if (_pictureController.text.isNotEmpty) {
        await uploadFileAvatar();
      }

      if (_documentController.text.isNotEmpty) {
        await uploadFileDocument();
      }

      if (skillattachments.isNotEmpty) {
        await uploadFile();
      }

      setState(() {
        getProperty.isLoading = false;
        getProperty.isInvisible = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      RouteService.taskers(ctx);
    } else {
      snackBarErr(context, 'Complete the Form');
    }
  }

  chooseFile() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile = result.files.single;
        // attachmentId = objFile!.bytes;
        attachmentName = objFile!.name;
        attachmentStream = objFile!.readStream;
        attachmentSize = objFile!.size;
        // isVisible = true;
        // uploadVisible = true;
      });
      _pictureController2.text = attachmentName.toString();

      // await uploadFile();
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
        // attachmentId = objFile!.bytes;
        attachmentNameAvatar = objFileAvatar!.name;
        attachmentStreamAvatar = objFileAvatar!.readStream;
        attachmentSizeAvatar = objFileAvatar!.size;

        // isVisible = true;
        // uploadVisible = true;
      });
      _pictureController.text = attachmentNameAvatar;
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

  clear() {
    _dialingController.clear();
    _phoneController.clear();

    _nameController.clear();
    _usernameController.clear();
    _emailController.clear();

    _passwordController.clear();
    _genderController.clear();
    _availabiltyController.clear();
    attachmentNameAvatar = '';
    _pictureController2.clear();
    _pictureController.clear();
    _experienceController.clear();
    profile_Details.clear();
    selectedCatagoryByAdmin.clear();

    _documentController.clear();
    _documentTypeController.clear();

    attachmentName = '';
    attachmentNameDoc = '';
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
      _documentController.text = attachmentNameDoc;
    }
  }

  uploadFileDocument() async {
    String postUrl = "${ApiEndPoint.endpoint}/taskers/attachment";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
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
