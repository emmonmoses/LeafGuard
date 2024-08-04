// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison, prefer_typing_uninitialized_variables
// Flutter imports:

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/category_main/category_main_update.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/main_api_endpoint.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:http/http.dart' as http;
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditMainCategory extends StatefulWidget {
  final String categoryId;

  const EditMainCategory({
    super.key,
    required this.categoryId,
  });

  @override
  State<EditMainCategory> createState() => _EditMainCategoryState();
}

class _EditMainCategoryState extends State<EditMainCategory> {
  late GlobalKey<FormState> _formKeyUpdateMainCategory;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pictureController = TextEditingController();
  var imageName;

  PlatformFile? objFile;
  MainCategory categoryObject = MainCategory();
  VariableService getProperty = VariableService();

  @override
  void initState() {
    super.initState();

    _formKeyUpdateMainCategory = GlobalKey();
  }

  @override
  Future<void> didChangeDependencies() async {
    categoryObject =
        await Provider.of<MainCategoryFactory>(context, listen: false)
            .getMainCategoryId(widget.categoryId);

    _nameController.text = categoryObject.name!;
    _descriptionController.text = categoryObject.description!;
    _pictureController.text = categoryObject.image!;
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
        key: _formKeyUpdateMainCategory,
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
                      // onChanged: (value) {
                      //   setState(() {
                      //     _taxNameController.text = value.toUpperCase();
                      //   });
                      // },
                      decoration: InputDecoration(
                        labelText: 'Name*',
                        hintText: 'e.g Plumber',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Image for catagory is required";
                        }
                        return null;
                      },
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 2,
                      style: const TextStyle(color: AppTheme.defaultTextColor),
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'e.g Description',
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
              RouteService.maincategories(context);
            },
            child: const Icon(
              Icons.arrow_left,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              RouteService.maincategories(context);
            },
            child: Text(
              "Edit Main Category",
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
                      RouteService.maincategories(context);
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
    if (_formKeyUpdateMainCategory.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      MainCategoryUpdate categoryObjects = MainCategoryUpdate(
        id: widget.categoryId,
        name: _nameController.text,
        image: _pictureController.text,
        description: _descriptionController.text,
      );

      await Provider.of<MainCategoryFactory>(context, listen: false)
          .updateMainCategory(categoryObjects);

      if (_pictureController.text != categoryObject.image.toString()) {
        await uploadFileAvatar();
      }

      setState(() {
        getProperty.isLoading = false;
      });

      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
    } else {
      snackBarError(ctx, _formKeyUpdateMainCategory);
    }
  }

  chooseFileImage() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    if (result != null) {
      setState(() {
        objFile = result.files.single;
        imageName = objFile!.name;
        _pictureController.text = imageName! == '' ? '' : imageName!;
      });
    }
  }

  var attachmentNameAvatar, attachmentSizeAvatar, attachmentStreamAvatar;
  PlatformFile? objFileAvatar;

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
    String postUrl = "${ApiEndPoint.endpoint}/maincategories/upload";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };
    // request.headers['Content-Type'] = 'multipart/form-data';

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

  goBack() {
    RouteService.maincategories(context);
  }
}
