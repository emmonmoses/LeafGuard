// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_responsive.dart';
import 'package:leafguard/themes/app_theme.dart';

// ignore: must_be_immutable
class PaginationWidget extends StatelessWidget {
  int page;
  final int pages;
  final VoidCallback? previous;
  final VoidCallback? next;
  PaginationWidget({
    Key? key,
    required this.previous,
    required this.next,
    required this.page,
    required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: previous == null ? null : () => previous!(),
                    child: const Text('<<Previous'),
                  ),
                  Text("Showing $page of $pages"),
                  TextButton(
                    onPressed: next == null ? null : () => next!(),
                    child: const Text('Next>>'),
                  ),
                ],
              )
            ],
          ),
          if (AppResponsive.isDesktop(context) ||
              AppResponsive.isTablet(context))
            appversionTile(
              'onestop',
              Icons.copyright_sharp,
              '${DateTime.now().year}',
            )
        ],
      ),
    );
  }
}

Widget appversionTile(txt, icon, text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(txt),
        Icon(
          icon,
          color: AppTheme.main,
        ),
        Text(text),
      ],
    ),
  );
}
