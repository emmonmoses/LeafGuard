// Projects Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/variables_service.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';

// Flutter Iports
import 'package:flutter/material.dart';
import 'package:leafguard/screens/question/create_question.dart';

// Package Imports
import 'package:provider/provider.dart';

class QuestionHeader extends StatefulWidget {
  const QuestionHeader({super.key});

  @override
  State<QuestionHeader> createState() => _QuestionHeaderState();
}

class _QuestionHeaderState extends State<QuestionHeader> {
  newQuestion() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateQuestion(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  VariableService getProperty = VariableService();

  @override
  void initState() {
    getProperty.getPermissions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            "Questions",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            if (getProperty.permissions!
                .where((permission) => permission.module == 'Questions')
                .any((p) => p.actions!
                    .any((action) => action.name!.contains('create'))))
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: newQuestion,
                      child: navigationIcon(
                        icon: Icons.add,
                        title: Text(
                          'New Question',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
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
