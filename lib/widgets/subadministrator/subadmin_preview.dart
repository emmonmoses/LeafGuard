// ignore_for_file: must_be_immutable, avoid_returning_null_for_void, unnecessary_null_comparison
// Project imports:

import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/subadministrator/subadminFactory.dart';
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/utilities/dialog_modal.dart';
import 'package:leafguard/widgets/general/fade_animation.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Package Imports

class PreviewSubAdmin extends StatefulWidget {
  final Administrator subAdmin;

  const PreviewSubAdmin({
    super.key,
    required this.subAdmin,
  });

  @override
  State<PreviewSubAdmin> createState() => _PreviewSubAdminState();
}

class _PreviewSubAdminState extends State<PreviewSubAdmin> {
  VariableService getProperty = VariableService();
  ScrollController scrollController = ScrollController();

  setVariables(ctx) {
    getProperty.width = MediaQuery.of(ctx).size.width;
    getProperty.file = ApiEndPoint.adminLogo;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      getProperty.isLoading = true;
    });

    setState(() {
      getProperty.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setVariables(context);

    return getProperty.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: -40,
                        width: getProperty.width,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-6.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background-5.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 200,
                        width: getProperty.width! + 20,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              "profile details".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: AppTheme.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: CircleAvatar(
                    radius: AppTheme.avatarSize,
                    backgroundImage: AssetImage(
                      ApiEndPoint.adminLogo,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: widget.subAdmin.adminNumber != null
                      ? Text(
                          widget.subAdmin.adminNumber!.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppTheme.black,
                                  ),
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'name'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  widget.subAdmin.name != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${widget.subAdmin.name}'
                                                    .toUpperCase(),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${widget.subAdmin.username}'
                                                    .toUpperCase(),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'username'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.subAdmin.username}'
                                              .toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'email'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppTheme.sizeBoxWidth),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.subAdmin.email}'
                                              .toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Roles',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      // Check if roles is null or empty, and display accordingly
                      if (widget.subAdmin.permissions == null ||
                          widget.subAdmin.permissions!.isEmpty)
                        const Center(
                          child: Text('No roles assigned to this user'),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            widget.subAdmin.permissions!.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors
                                      .green, // Set your desired background color here
                                  elevation: 8.0,
                                  // Adjust elevation as needed
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),

                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: 30,
                                    ), // You can adjust the icon color
                                    title: Text(
                                        widget.subAdmin.permissions![index]
                                            .module!,
                                        style: const TextStyle(
                                            color: Colors
                                                .white)), // You can adjust the text color
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: widget
                                          .subAdmin.permissions![index].actions!
                                          .map(
                                            (action) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.check,
                                                    color: Colors.yellowAccent),
                                                Text(
                                                  action.name!,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  delete(element, ctx) async {
    final action = await ConfirmationDialog.yesAbortDialog(
        context,
        'DeleteConfirmation',
        'Are you sure you wish to delete ${element.name.toUpperCase()} from roles list');
    if (action == DialogAction.yes) {
      setState(() {
        deleteSubAdminRole(element._id, ctx);
      });
    } else {
      setState(() => null);
    }
  }

  deleteSubAdminRole(id, ctx) async {
    final response =
        await Provider.of<SubAdministratorFactory>(context, listen: false)
            .deleteRole(id);
    snackBarNotification(ctx, ToasterService.successMsg);
    return response;
  }
}
