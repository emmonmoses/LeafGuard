// ignore_for_file: must_be_immutable, unused_element, unnecessary_null_comparison
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/controllers/route_controller.dart';
import 'package:leafguard/models/question/question.dart';
import 'package:leafguard/models/question/question_update.dart';
import 'package:leafguard/services/question/questionFactory.dart';

// Project imports:
import 'package:leafguard/services/toaster_service.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/models/search/search.dart';
import 'package:leafguard/screens/question/home.dart';

// Package Imports
import 'package:provider/provider.dart';

class EditQuestion extends StatefulWidget {
  static const routeName = '/questionupdate';

  const EditQuestion({super.key});

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  late GlobalKey<FormState> _formKeyUpdateQuestion;

  final _questionController = TextEditingController();

  int questionStatus = 0;
  int questionValue = 0;

  VariableService getProperty = VariableService();

  Constants search = Constants();
  Question updatedQuestion = Question();

  @override
  void initState() {
    super.initState();
    _formKeyUpdateQuestion = GlobalKey();
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    final question = ModalRoute.of(context)!.settings.arguments as Question;

    if (getProperty.isInit) {
      updatedQuestion =
          await Provider.of<QuestionFactory>(context, listen: false)
              .getQuestionId(question.id);

      _questionController.text = updatedQuestion.question!;
      setState(() {
        questionStatus = updatedQuestion.status!;
        getProperty.isActive = questionStatus == 1;
      });
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
        key: _formKeyUpdateQuestion,
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
                      controller: _questionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Question cannot be empty';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Question*',
                        hintText: 'e.g About you',
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
                  child: SwitchListTile(
                    title: const Text(
                      'Status',
                      style: TextStyle(
                        color: AppTheme.defaultTextColor,
                      ),
                    ),
                    subtitle: questionStatus == 1
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
                        questionStatus = getProperty.isActive ? 1 : 0;
                      });
                    },
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
                  pageBuilder: (_, __, ___) => const QuestionHome(),
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
              RouteService.questions(context);
            },
            child: Text(
              "Edit Question",
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
                      RouteService.questions(context);
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
    if (_formKeyUpdateQuestion.currentState!.validate()) {
      setState(() {
        getProperty.isLoading = true;
      });
      QuestionUpdate questionObject = QuestionUpdate(
        question_tag: _questionController.text,
        question_status: questionStatus,
        id: updatedQuestion.id!,
      );
      await Provider.of<QuestionFactory>(context, listen: false)
          .updateQuestion(questionObject);
      setState(() {
        getProperty.isLoading = false;
      });
      snackBarNotification(ctx, ToasterService.successMsg);
      goBack();
      // returnHome();
    } else {
      snackBarError(ctx, _formKeyUpdateQuestion);
    }
  }

  goBack() {
    RouteService.questions(context);
  }
}
