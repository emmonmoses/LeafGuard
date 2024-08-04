// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/agents/agent_update.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/services/agent/agentFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/screens/administrator/home.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/models/search/search.dart';
import 'package:http/http.dart' as http;

// Package Imports
import 'package:provider/provider.dart';

class EditAgent extends StatefulWidget {
  static const routeName = '/agentupdate';

  const EditAgent({super.key});

  @override
  State<EditAgent> createState() => _EditAgentState();
}

class _EditAgentState extends State<EditAgent> {
  late GlobalKey<FormState> _formKeyUpdateAgent;

  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _dialingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _availabiltyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pictureController = TextEditingController();
  final _documentController = TextEditingController();

  Constants search = Constants();
  VariableService dataservice = VariableService();
  var attachmentName, attachmentSize, attachmentStream;
  var attachmentNameAvatar, attachmentSizeAvatar, attachmentStreamAvatar;
  PlatformFile? objFileAvatar;
  PlatformFile? objFile;

  Phone phone = Phone();
  Agent updatedAgent = Agent();

  int agentStatus = 0;
  int userValue = 0;

  String dropdownValue = 'Change Role';

  @override
  void initState() {
    super.initState();
    _formKeyUpdateAgent = GlobalKey();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _genderController.dispose();
    _dialingController.dispose();
    _phoneController.dispose();
    _availabiltyController.dispose();
    _descriptionController.dispose();
    _pictureController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    final agent = ModalRoute.of(context)!.settings.arguments as Agent;

    if (dataservice.isInit) {
      updatedAgent = await Provider.of<AgentFactory>(context, listen: false)
          .getAgentId(agent.id);

      _nameController.text = updatedAgent.name!;
      _emailController.text = updatedAgent.email!;
      _usernameController.text = updatedAgent.username!;
      // _genderController.text = updatedAgent.gender!;
      _dialingController.text = updatedAgent.phone!.code;
      _phoneController.text = updatedAgent.phone!.number.toString();
      _availabiltyController.text = updatedAgent.address!;
      _descriptionController.text = updatedAgent.description!;
      _pictureController.text = updatedAgent.avatar!;
      _documentController.text = updatedAgent.document!;

      agentStatus = updatedAgent.status!;
      dataservice.isActive = agentStatus == 1;

      var g = updatedAgent.gender.toString();
      _genderController.text = updatedAgent.gender.toString();

      setState(() {
        if (g == "Male") {
          dataservice.isMaleSelected = true;
          dataservice.isFemaleSelected = false;
        } else {
          dataservice.isMaleSelected = false;
          dataservice.isFemaleSelected = true;
        }
      });

      if (updatedAgent.status == 1) {
        agentStatus = updatedAgent.status!;
        dataservice.providerStatus = 1;
        dataservice.isActive = true;
      } else {
        agentStatus = updatedAgent.status!;
        dataservice.providerStatus = 0;
        dataservice.isActive = false;
      }
    }
    dataservice.isInit = false;

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
        key: _formKeyUpdateAgent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            updateHeader,
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
                        labelText: 'Full Name*',
                        hintText: 'e.g John Doe',
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
                    padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: Text(
                          dataservice.dropdownGender,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  dataservice.isMaleSelected = true;
                                  dataservice.isFemaleSelected = false;
                                  _genderController.text = "Male";
                                });
                              },
                              icon: const Icon(Icons.male),
                              label: const Text('Male'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: dataservice.isMaleSelected
                                    ? AppTheme.main
                                    : AppTheme.defaultTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  dataservice.isMaleSelected = false;
                                  dataservice.isFemaleSelected = true;
                                  _genderController.text = "Female";
                                });
                              },
                              icon: const Icon(Icons.female),
                              label: const Text('Female'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: dataservice.isFemaleSelected
                                    ? AppTheme.main
                                    : AppTheme.defaultTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                    subtitle: agentStatus == 1
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
                    value: dataservice.isActive,
                    onChanged: (bool value) {
                      setState(() {
                        dataservice.isActive = value;
                        agentStatus = value ? 1 : 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Expanded(
                //   child: Container(
                //     padding: const EdgeInsets.only(
                //         top: 25.0, left: 15.0, right: 15.0, bottom: 15.0),
                //     child: IntlPhoneField(
                //       style: const TextStyle(
                //         color: AppTheme.defaultTextColor,
                //       ),
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
                //           _dialingController.text = phone.countryCode;
                //           _phoneController.text = phone.number;
                //         });
                //       },
                //     ),
                //   ),
                // ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _dialingController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Dialing Code',
                        hintText: 'e.g +251',
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
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    child: TextFormField(
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
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
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
                            'Click the icon on the right to upload Document',
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
                  pageBuilder: (_, __, ___) => const AdministratorHome(),
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
              RouteService.agents(context);
            },
            child: Text(
              "Edit Agent",
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
                      RouteService.agents(context);
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
      _pictureController.text = attachmentNameAvatar;
    }
  }

  uploadFileAvatar() async {
    String postUrl = "${ApiEndPoint.endpoint}/agents/upload";

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

  chooseFileDocument() async {
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
      _documentController.text = attachmentName;
    }
  }

  uploadFileDocument() async {
    String postUrl = "${ApiEndPoint.endpoint}/agents/attachment";

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

  save(ctx) {
    if (_documentController.text.isEmpty) {
      snackBarErr(ctx, 'Upload Document is required');
      return;
    }
    if (_formKeyUpdateAgent.currentState!.validate()) {
      setState(() {
        dataservice.isLoading = true;
      });

      AgentUpdate adminObject = AgentUpdate(
        id: updatedAgent.id!,
        phone: Phone(
          code: _dialingController.text,
          number: _phoneController.text,
        ),
        username: _usernameController.text,
        name: _nameController.text,
        avatar: _pictureController.text,
        document: _documentController.text,
        gender: _genderController.text,
        email: _emailController.text,
        address: _availabiltyController.text,
        status: agentStatus,
        description: _descriptionController.text,
      );

      Provider.of<AgentFactory>(context, listen: false)
          .updateAgent(adminObject);

      if (_pictureController.text != updatedAgent.avatar.toString()) {
        uploadFileAvatar();
      }
      if (_documentController.text != updatedAgent.document.toString()) {
        uploadFileDocument();
      }
      setState(() {
        dataservice.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      // returnHome();
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateAgent);
    }
  }

  goBack() {
    RouteService.agents(context);
  }
}
