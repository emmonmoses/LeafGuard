// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
// Project imports:
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/address/address_witness.dart';
import 'package:leafguard/models/provider/provider_create_return.dart';
import 'package:leafguard/models/witness/witness.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/sharedpref_service.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:http/http.dart' as http;
import 'package:leafguard/models/witness/witness_create.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreateWitness extends StatefulWidget {
  const CreateWitness({Key? key}) : super(key: key);

  @override
  CreateWitnessState createState() => CreateWitnessState();
}

class CreateWitnessState extends State<CreateWitness> {
  late GlobalKey<FormState> _formKeyCreateWitnesses;
  bool isSent = false;
  bool isLoading = false;

  final _taskerController = TextEditingController();
  ProviderCreateReturn? taskers;

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
  List<Witness> taskerwitness = [];
  var attachmentName1, attachmentSize1, attachmentStream1;
  var attachmentName2, attachmentSize2, attachmentStream2;
  PlatformFile? objFile2;
  PlatformFile? objFile1;

  int userStatus = 0;
  num currencyValue = 0;
  VariableService getProperty = VariableService();
  ServiceProviderFactory? fnp;
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _formKeyCreateWitnesses = GlobalKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProperty.loadData(context);
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
        key: _formKeyCreateWitnesses,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newWitnessHeader,
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
                      controller: _taskerController,
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
                            if (_taskerController.text.isEmpty) {
                              return;
                            } else {
                              callGetProviderById(id: _taskerController.text);
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
                      autovalidateMode: AutovalidateMode.always,
                      // controller: _phoneController,
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
                          _phoneController.text =
                              phone.countryCode + phone.number;
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Choose Document to upload';
                        }
                        return null;
                      },
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
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _countryController,
                      readOnly: true,
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
              padding: const EdgeInsets.only(left: 15.0),
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
                          _phoneController2.text =
                              phone.countryCode + phone.number;
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Choose Document to upload';
                        }
                        return null;
                      },
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

  Widget get newWitnessHeader {
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
              RouteService.taskers(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.taskers(context);
            },
            child: Text(
              "New Witness",
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
                    onTap: () => sendData(context),
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

  clear() {
    _taskerController.clear();
    _nameController.clear();
    _nameController2.clear();
    _documentController.clear();
    _documentController2.clear();
    _nationalIdController.clear();
    _nationalIdController2.clear();
    _phoneController.clear();
    _phoneController2.clear();
    _lineController.clear();
    _lineController2.clear();
    _cityController.clear();
    _cityController2.clear();
    _countryController.clear();
    _countryController2.clear();
    _stateController.clear();
    _stateController2.clear();
    attachmentName1 = '';
    attachmentName2 = '';
    isSent = false;
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

  void setTaskers(ServiceProviderFactory fnp) {
    setState(() {
      taskers = fnp.provider;
    });
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

  sendData(ctx) async {
    if (taskers == null) {
      snackBarErr(ctx, 'Search for a valid provider before saving');
      return;
    }

    if (_taskerController.text != taskers!.taskerNumber.toString()) {
      snackBarErr(ctx, 'Type in the valid id of the Service provider');
      return;
    }

    if (_phoneController.text.isEmpty || _phoneController2.text.isEmpty) {
      snackBarErr(ctx, 'Witness phone number is required');
      return;
    }

    if (_formKeyCreateWitnesses.currentState!.validate()) {
      List<Witness> witness = [
        Witness(
          nationalId: _nationalIdController.text,
          name: _nameController.text,
          phone: _phoneController.text,
          document: attachmentName1,
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
          document: attachmentName2,
          address: AddressWitness(
            line: _lineController2.text,
            city: _cityController2.text,
            country: _countryController2.text,
            state: _stateController2.text,
          ),
        ),
      ];

      var result = await Provider.of<WitnessFactory>(context, listen: false)
          .createWitness(taskers!.id, witness);

      await uploadFilewitness1();
      await uploadFileWitness2();
      if (result.runtimeType == WitnessCreate) {
        snackBarNotification(context, ToasterService.successMsg);

        clear();
      } else {
        snackBarErr(ctx, ToasterService.errorMsg);
      }
    } else {
      snackBarError(ctx, _formKeyCreateWitnesses);
    }
  }
}
