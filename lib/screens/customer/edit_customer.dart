// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/address/address.dart';
import 'package:leafguard/models/location/location.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/customer/customer.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/customer/customerFactory.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:http/http.dart' as http;

// Package Imports
import 'package:provider/provider.dart';

class EditCustomer extends StatefulWidget {
  final String userId;

  const EditCustomer({super.key, required this.userId});

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  late GlobalKey<FormState> _formKeyUpdateUser;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _dialingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pictureController = TextEditingController();
  final _documentTypeController = TextEditingController();
  final _documentController = TextEditingController();

  int? userStatus = 0;
  int userValue = 0;
  String profilePic = '';
  String key = 'storedToken';
  double? latitude, longitude;

  DateTime selectedDate = DateTime.now();
  DateTime today = DateTime.now();

  var attachmentName, attachmentSize, attachmentStream;
  var imagePath, imageName, imageSize, imageStream;
  DateTime? createdAt, updatedAt;
  late GlobalKey<FormState> _formKeyEditUser;
  final baseUrl = ApiEndPoint.getCustomerImage;
  String dropdownValue = 'Select DocumentType';

  Phone phone = Phone();
  PlatformFile? objFile;
  PlatformFile? objFileDoc;
  Customer userObject = Customer();
  Address address = Address();
  String? dd;
  List<Location> coordinates = [];
  SharedPref sharedPref = SharedPref();
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();
    getProperty.isLoading = true;
    getProperty.isInvisible = true;
    _formKeyEditUser = GlobalKey();
  }

  @override
  Future<void> didChangeDependencies() async {
    userObject = await Provider.of<CustomerFactory>(context, listen: false)
        .getCustomerId(widget.userId);

    _nameController.text = userObject.name != null ? userObject.name! : "";
    _emailController.text = userObject.email != null ? userObject.email! : "";
    _usernameController.text =
        userObject.username != null ? userObject.username! : "";
    // _passwordController.text = userObject.password!;
    _countryController.text =
        userObject.address != null ? userObject.address!.country! : "";
    _cityController.text =
        userObject.address != null ? userObject.address!.city! : "";
    _stateController.text =
        userObject.address != null ? userObject.address!.state! : "";
    _zipcodeController.text =
        userObject.address != null ? userObject.address!.zipcode! : "";
    _line1Controller.text =
        userObject.address != null ? userObject.address!.line1! : "";
    _line2Controller.text =
        userObject.address != null ? userObject.address!.line2! : "";
    _dialingController.text =
        userObject.phone != null ? userObject.phone!.code! : "";
    _phoneController.text =
        userObject.phone != null ? userObject.phone!.number : "";
    _pictureController.text =
        userObject.avatar != null ? userObject.avatar! : "";
    _documentController.text =
        userObject.document != null ? userObject.document! : "";
    _documentTypeController.text =
        userObject.documentType != null ? userObject.documentType! : "";

    dropdownValue = userObject.documentType != null
        ? userObject.documentType!
        : "Select DocumentType";
    userStatus = userObject.status!;
    // getProperty.isActive = userStatus == 1;
    createdAt = userObject.createdAt;
    updatedAt = userObject.updatedAt;
    profilePic = ApiEndPoint.appLogo;
    dd = userObject.dateOfBirth != null
        ? userObject.dateOfBirth.toString()
        : "${selectedDate.toLocal()}".split(' ')[0];

    if (userStatus == 1) {
      getProperty.providerStatus = 1;
      getProperty.isActive = true;
    } else {
      getProperty.providerStatus = 0;
      getProperty.isActive = false;
    }

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
    DateTime firstDate = today.subtract(const Duration(days: 365 * 70));
    DateTime lastDate = today.subtract(const Duration(days: 365 * 18));
    return SingleChildScrollView(
      child: Form(
        key: _formKeyEditUser,
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
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Fullname*',
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
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
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
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username*',
                        hintText: 'e.g jdoe',
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
                    subtitle: getProperty.providerStatus == 1
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
                        userStatus = getProperty.isActive ? 1 : 0;
                        getProperty.providerStatus = userStatus as int;
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
                      readOnly: true,
                      controller: TextEditingController(
                        // text: "${selectedDate.toLocal()}".split(' ')[0],
                        text: dd,
                      ),
                      validator: (value) {
                        if (value ==
                            "${DateTime.now().toLocal()}".split(' ')[0]) {
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
                                  dialogBackgroundColor: AppTheme.white,
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(secondary: AppTheme.main),
                                ),
                                child: child!);
                          },
                          context: context,
                          initialDate: lastDate,
                          firstDate: firstDate,
                          lastDate: lastDate,
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                            dd = "${selectedDate.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              BorderSide(color: AppTheme.main, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        hintText: 'Select a date',
                        hintStyle: const TextStyle(color: Colors.grey),
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address cannot be empty';
                        } else if (value.isEmpty) {
                          return 'Address must be field.';
                        }
                        return null;
                      },
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _line1Controller,
                      decoration: InputDecoration(
                        labelText: 'Address 1',
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
                      style: const TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                      controller: _line2Controller,
                      decoration: InputDecoration(
                        labelText: 'Address 2',
                        hintText: 'e.g it could be name of building etc',
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
                              _dialingController.text = country.phoneCode;
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
                      decoration: InputDecoration(
                        labelText: 'City',
                        hintText: 'e.g Addis Ababa',
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
                      controller: _dialingController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Dialing Code',
                        hintText: 'e.g +254',
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
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone*',
                        hintText: 'e.g 902000111',
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
                      controller: _stateController,
                      decoration: InputDecoration(
                        labelText: 'State(region)',
                        hintText: 'e.g Addis Ababa',
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
                      controller: _zipcodeController,
                      decoration: InputDecoration(
                        labelText: 'Zipcode',
                        hintText: 'e.g 00502',
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
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: <String>[
                        'Select DocumentType',
                        'Driving License',
                        'National ID',
                        'Passport',
                        'Kebele ID',
                      ].map<DropdownMenuItem<String>>((String value) {
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
                                    color: AppTheme.defaultTextColor,
                                  ),
                                ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (dropdownValue != 'Select DocumentType') {
                            _documentTypeController.text = dropdownValue;
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
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (_documentTypeController.text !=
                            'Select DocumentType') {
                          if (value!.isEmpty) {
                            return 'Documents of the Customer is Mandatory';
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
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: true,
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        style:
                            const TextStyle(color: AppTheme.defaultTextColor),
                        readOnly: true,
                        controller: _pictureController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                        "Upload Picture",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                        ),
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
              RouteService.customers(context);
            },
            child: const Icon(
              Icons.arrow_left,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              RouteService.customers(context);
            },
            child: Text(
              "Edit Customer",
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
                      RouteService.customers(context);
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
    if (_documentTypeController.text.isEmpty) {
      snackBarErr(ctx, 'Document Type is required');
      return;
    }
    if (_documentController.text.isEmpty) {
      snackBarErr(ctx, 'Upload Document is required');
      return;
    }
    if (_formKeyEditUser.currentState!.validate()) {
      var dateOfBirth =
          '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
      setState(() {
        getProperty.isLoading = true;
      });
      Customer userObject = Customer(
        name: _nameController.text,
        email: _emailController.text,
        username: _usernameController.text,
        avatar: _pictureController.text,
        dateOfBirth: dateOfBirth,
        // password: _passwordController.text == ''
        //     ? '123456'
        //     : _passwordController.text,
        address: Address(
          line1: _line1Controller.text,
          line2: _line2Controller.text,
          city: _cityController.text,
          country: _countryController.text,
          state: _stateController.text,
          zipcode: _zipcodeController.text,
          // formatted_address:
          //     "${_line1Controller.text},${_cityController.text},${_countryController.text},${_stateController.text},${_zipcodeController.text}",
        ),
        phone: Phone(
          code: _dialingController.text,
          number: _phoneController.text,
        ),
        // status: getProperty.providerStatus,
        status: userStatus,
        id: widget.userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        document: _documentController.text,
        documentType: _documentTypeController.text,
      );

      await Provider.of<CustomerFactory>(context, listen: false)
          .updateCustomer(userObject);

      if (_pictureController.text != userObject.avatar) {
        await uploadFileAvatar();
      }

      if (_documentController.text != userObject.document) {
        await uploadFileDocument();
      }

      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateUser);
    }
  }

  goBack() {
    RouteService.customers(context);
  }

  chooseFile() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile = result.files.single;
        imageSize = objFile!.size;
        imageStream = objFile!.readStream;
        imageName = objFile!.name;
        _pictureController.text = imageName;
      });
    }
  }

  uploadFileAvatar() async {
    String postUrl = "${ApiEndPoint.endpoint}/users/upload";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "avatar",
      imageStream,
      imageSize,
      filename: imageName,
    ));

    request.send().then(
      (result) async {
        http.Response.fromStream(result).then((response) {
          return response.body;
        });
      },
    ).catchError((err) => toastError(err));
  }

  chooseFileDocument() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFileDoc = result.files.single;
        attachmentName = objFileDoc!.name;
        attachmentStream = objFileDoc!.readStream;
        attachmentSize = objFileDoc!.size;
      });
      _documentController.text = attachmentName;
    }
  }

  uploadFileDocument() async {
    String postUrl = "${ApiEndPoint.endpoint}/users/attachment";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.headers.addAll(headers);

    // add selected file with request
    request.files.add(http.MultipartFile(
      "avatar",
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
}
