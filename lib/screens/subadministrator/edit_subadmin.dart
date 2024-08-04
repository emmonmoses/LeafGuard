// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:

import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/actions/actions.dart';
import 'package:leafguard/models/permissions/permissions.dart';
import 'package:leafguard/models/sidebarMenuItem/sidebar_menu_item.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/subadministrator/subadminFactory.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/models/search/search.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditSubAdministrator extends StatefulWidget {
  final Administrator admin;

  const EditSubAdministrator({super.key, required this.admin});

  @override
  State<EditSubAdministrator> createState() => _EditAdministratorState();
}

class _EditAdministratorState extends State<EditSubAdministrator> {
  late GlobalKey<FormState> _formKeyUpdateAdmin;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final roleController = TextEditingController();
  final statusController = TextEditingController();

  Constants search = Constants();
  Permissions role = Permissions();
  VariableService getProperty = VariableService();
  Administrator updatedAdmin = Administrator();

  late List<bool> checkedList;
  List<Permissions> priviledges = [];
  Map<String, dynamic> selectedActions = {};

  Permissions? menu;
  int? userStatus = 0;
  int userValue = 0;
  bool isChecked = false;
  String dropdownValue = 'Change Role';

  @override
  void initState() {
    super.initState();
    checkedList = List.filled(sidebarMenuItems.length, false);

    _formKeyUpdateAdmin = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    // admin = ModalRoute.of(context)!.settings.arguments as Administrator?;

    if (getProperty.isInit) {
      updatedAdmin =
          await Provider.of<SubAdministratorFactory>(context, listen: false)
              .getSubAdminId(widget.admin.id);

      nameController.text = updatedAdmin.name!;
      emailController.text = updatedAdmin.email!;
      usernameController.text = updatedAdmin.username!;
      roleController.text = updatedAdmin.role!;
      statusController.text = updatedAdmin.status!.toString();
      setState(() {
        userStatus = updatedAdmin.status!;
        getProperty.isActive = userStatus == 1;
        priviledges = updatedAdmin.permissions!;
      });
    }
    getProperty.isInit = false;

    super.didChangeDependencies();
  }

  avaliablePermissions() {}

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
        key: _formKeyUpdateAdmin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader,
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
                      controller: nameController,
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
                      controller: emailController,
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
                      controller: usernameController,
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
                    subtitle: userStatus == 1
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
                    margin: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.defaultTextColor,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: AppTheme.defaultTextColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          dropdownValue == 'Admin'
                              ? roleController.text = 'admin'
                              : roleController.text = 'subadmin';
                        });
                      },
                      items: <String>[
                        'Change Role',
                        'Admin',
                        'Sub Admin',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != 'Change Role',
                          child: value == 'Change Role'
                              ? Text(
                                  value,
                                  style: TextStyle(
                                    color: AppTheme.grey,
                                  ),
                                )
                              : Text(value),
                        );
                      }).toList(),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                  child: Text(
                    'Access Permissions',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.main,
                        ),
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(15.0),
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    sidebarMenuItems[index].isExpanded = !isExpanded;
                  });
                },
                children: sidebarMenuItems.asMap().entries.map<ExpansionPanel>(
                  (entry) {
                    int index = entry.key;
                    Item item = entry.value;
                    isChecked = checkedList[index];
                    bool isMatching = widget.admin.permissions!.any((p) =>
                        p.module!.toLowerCase() ==
                        item.headerText.toLowerCase());
                    isMatching
                        ? selectedActions.putIfAbsent(
                            item.headerText,
                            () => {
                                  'access': widget.admin.permissions!
                                          .where((p) =>
                                              p.module == item.headerText)
                                          .any((p) => p.actions!.any((a) =>
                                              a.name!.contains('access')))
                                      ? true
                                      : false,
                                  'create': widget.admin.permissions!
                                          .where((p) =>
                                              p.module == item.headerText)
                                          .any((p) => p.actions!.any((a) =>
                                              a.name!.contains('create')))
                                      ? true
                                      : false,
                                  'delete': widget.admin.permissions!
                                          .where((p) =>
                                              p.module == item.headerText)
                                          .any((p) => p.actions!.any((a) =>
                                              a.name!.contains('delete')))
                                      ? true
                                      : false,
                                })
                        : null;
                    return ExpansionPanel(
                      backgroundColor: Colors.grey.shade300,
                      isExpanded: item.isExpanded,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            item.headerText,
                            style: TextStyle(
                              color: isMatching
                                  ? AppTheme.main
                                  : AppTheme.defaultTextColor,
                            ),
                          ),
                        );
                      },
                      body: Row(
                        children: [
                          for (var action in roles)
                            Row(
                              children: [
                                if (item.headerText != "Dashboard")
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Checkbox(
                                      value: selectedActions[item.headerText]
                                              ?[action.create] ??
                                          false,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedActions[item.headerText] = {
                                            ...selectedActions[
                                                    item.headerText] ??
                                                {},
                                            action.create: value!,
                                          };
                                          updatePrivilegesList(item.headerText,
                                              action.create, value);
                                        });
                                      },
                                      activeColor: isMatching
                                          ? AppTheme.main
                                          : AppTheme.grey,
                                      checkColor: Colors.white,
                                    ),
                                  ),
                                if (item.headerText != "Dashboard")
                                  Text(action.create.toUpperCase()),
                                const SizedBox(width: 16),
                                Checkbox(
                                  value: selectedActions[item.headerText]
                                          ?[action.access] ??
                                      false,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedActions[item.headerText] = {
                                        ...selectedActions[item.headerText] ??
                                            {},
                                        action.access: value!,
                                      };
                                      updatePrivilegesList(item.headerText,
                                          action.access, value);
                                    });
                                  },
                                  activeColor: isMatching
                                      ? AppTheme.main
                                      : AppTheme.grey,
                                  checkColor: Colors.white,
                                ),
                                Text(action.access.toUpperCase()),
                                const SizedBox(width: 16),
                                if (item.headerText != "Dashboard")
                                  Checkbox(
                                    value: selectedActions[item.headerText]
                                            ?[action.delete] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedActions[item.headerText] = {
                                          ...selectedActions[item.headerText] ??
                                              {},
                                          action.delete: value!,
                                        };
                                        updatePrivilegesList(item.headerText,
                                            action.delete, value);
                                      });
                                    },
                                    activeColor: isMatching
                                        ? AppTheme.main
                                        : AppTheme.grey,
                                    checkColor: Colors.white,
                                  ),
                                if (item.headerText != "Dashboard")
                                  Text(action.delete.toUpperCase()),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            // END OF THE REFACTOR
          ],
        ),
      ),
    );
  }

  Widget get _buildHeader {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          _buildMenuIcon(),
          _buildBackButton(),
          _buildEditSubAdminTitle(),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            _buildCancelSaveButtons(),
          }
        ],
      ),
    );
  }

  Widget _buildMenuIcon() {
    return IconButton(
      tooltip: 'Menu',
      icon: const Icon(Icons.menu),
      onPressed: Provider.of<custom.MenuController>(context, listen: false)
          .controlMenu,
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        RouteService.subAdministrators(context);
      },
      child: const Icon(Icons.arrow_left, size: 30),
    );
  }

  Widget _buildEditSubAdminTitle() {
    return InkWell(
      onTap: () {
        RouteService.subAdministrators(context);
      },
      child: Text(
        "Edit Sub-Admin",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget _buildCancelSaveButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNavigationIcon(
          icon: Icons.cancel,
          title: Text(
            'Cancel',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.main,
                ),
          ),
          onTap: () {
            RouteService.subAdministrators(context);
          },
        ),
        _buildNavigationIcon(
          icon: Icons.save,
          title: Text(
            'Save',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.main,
                ),
          ),
          onTap: () => save(context),
        ),
      ],
    );
  }

  Widget _buildNavigationIcon(
      {required IconData icon,
      required Widget title,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Container(
              child: title,
            )
          ],
        ),
      ),
    );
  }

  void updatePrivilegesList(String headerText, String action, bool value) {
    int existingIndex =
        priviledges.indexWhere((privilege) => privilege.module == headerText);

    if (value) {
      // Add privilege to the list
      if (existingIndex == -1) {
        // If module doesn't exist, create a new entry
        priviledges.add(
          Permissions(
            module: headerText,
            actions: [ActionMenu(name: '${action}_$headerText'.toLowerCase())],
          ),
        );
      } else {
        // If module exists, add action to existing actions list
        priviledges[existingIndex]
            .actions
            ?.add(ActionMenu(name: '${action}_$headerText'.toLowerCase()));
      }
    } else {
      // Remove privilege from the list using a for loop
      for (int i = 0; i < priviledges.length; i++) {
        if (priviledges[i].module == headerText) {
          priviledges[i].actions?.removeWhere(
              (a) => a.name == '${action}_$headerText'.toLowerCase());

          // Check if actions list is empty after removal, then remove the entire permission
          if (priviledges[i].actions?.isEmpty ?? false) {
            priviledges.removeAt(i);
          }
        }
      }
    }
  }

  save(ctx) async {
    if (_formKeyUpdateAdmin.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      Administrator adminObject = Administrator(
        username: usernameController.text,
        name: nameController.text,
        email: emailController.text,
        role: roleController.text,
        status: userStatus,
        id: updatedAdmin.id,
        createdAt: updatedAdmin.createdAt,
        updatedAt: updatedAdmin.updatedAt,
        permissions: priviledges,
      );
      await Provider.of<SubAdministratorFactory>(context, listen: false)
          .updateAdmin(adminObject);
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      RouteService.subAdministrators(ctx);
    } else {
      snackBarError(ctx, _formKeyUpdateAdmin);
    }
  }
}
