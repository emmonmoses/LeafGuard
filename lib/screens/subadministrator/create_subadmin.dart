// ignore_for_file: prefer_typing_uninitialized_variables
// Project imports:
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/models/actions/actions.dart';
import 'package:leafguard/models/permissions/permissions.dart';
import 'package:leafguard/models/sidebarMenuItem/sidebar_menu_item.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/services/subadministrator/subadminFactory.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class CreateSubAdministrator extends StatefulWidget {
  const CreateSubAdministrator({Key? key}) : super(key: key);

  @override
  CreateSubAdministratorState createState() => CreateSubAdministratorState();
}

class CreateSubAdministratorState extends State<CreateSubAdministrator> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  int userStatus = 1;
  bool isChecked = false;

  late List<bool> checkedList;
  List<Permissions> priviledges = [];
  Permissions role = Permissions();
  VariableService getProperty = VariableService();
  Map<String, Map<String, bool>> selectedActions = {};

  SharedPref sharedPref = SharedPref();
  late GlobalKey<FormState> _formKeyCreateAdmin;

  @override
  void initState() {
    super.initState();
    checkedList = List.filled(sidebarMenuItems.length, false);

    _formKeyCreateAdmin = GlobalKey();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
        key: _formKeyCreateAdmin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            newAdminHeader,
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
                          userStatus = 1;
                        } else {
                          userStatus = 0;
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
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 3) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password*',
                        hintText: 'e.g jD&moh@1',
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
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
                children: sidebarMenuItems
                    .asMap()
                    .entries
                    .map<ExpansionPanel>((entry) {
                  Item item = entry.value;
                  return ExpansionPanel(
                    backgroundColor: Colors.grey.shade300,
                    isExpanded: item.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          item.headerText,
                          style: const TextStyle(
                            color: Colors.black,
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
                                          ...selectedActions[item.headerText] ??
                                              {},
                                          action.create: value!,
                                        };
                                        updatePrivilegesList(item.headerText,
                                            action.create, value);
                                        if (value == true) {
                                          isChecked = true;
                                        } else {
                                          isChecked = false;
                                        }
                                      });
                                    },
                                    activeColor: isChecked
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
                                      ...selectedActions[item.headerText] ?? {},
                                      action.access: value!,
                                    };
                                    updatePrivilegesList(
                                        item.headerText, action.access, value);
                                    if (value == true) {
                                      isChecked = true;
                                    } else {
                                      isChecked = false;
                                    }
                                  });
                                },
                                activeColor:
                                    isChecked ? AppTheme.main : AppTheme.grey,
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
                                      if (value == true) {
                                        isChecked = true;
                                      } else {
                                        isChecked = false;
                                      }
                                    });
                                  },
                                  activeColor:
                                      isChecked ? AppTheme.main : AppTheme.grey,
                                  checkColor: Colors.white,
                                ),
                              if (item.headerText != "Dashboard")
                                Text(action.delete.toUpperCase()),
                            ],
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
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
    if (_formKeyCreateAdmin.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
        getProperty.isInvisible = true;
      });

      await Provider.of<SubAdministratorFactory>(context, listen: false)
          .createSubAdmin(
        _nameController.text,
        _emailController.text,
        _usernameController.text,
        _passwordController.text,
        userStatus,
        priviledges,
      );

      setState(() {
        getProperty.isLoading = false;
        getProperty.isInvisible = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      clear();
    } else {
      snackBarError(ctx, _formKeyCreateAdmin);
    }
  }

  clear() {
    _nameController.clear();
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
  }

  Widget get newAdminHeader {
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
              RouteService.subAdministrators(context);
            },
          ),
          InkWell(
            onTap: () {
              RouteService.subAdministrators(context);
            },
            child: Text(
              "New Sub-Admin",
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
                      RouteService.subAdministrators(context);
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
}
