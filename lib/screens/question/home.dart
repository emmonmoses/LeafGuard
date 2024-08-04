// Project Imports
import 'package:leafguard/controllers/sidebar_controller.dart';
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/themes/app_responsive.dart';
// Flutter Imports
import 'package:flutter/material.dart';
import 'package:leafguard/screens/question/question.dart';
// Package Imports
import 'package:provider/provider.dart';

class QuestionHome extends StatefulWidget {
  static const routeName = '/questions';

  const QuestionHome({super.key});

  @override
  State<QuestionHome> createState() => _QuestionHomeState();
}

class _QuestionHomeState extends State<QuestionHome> {
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
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            const Expanded(
              flex: 4,
              child: QuestionIndex(),
            ),
          ],
        ),
      ),
    );
  }
}
