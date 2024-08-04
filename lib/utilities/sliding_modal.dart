// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';

Future<T?> showModalSideSheet<T extends Object?>({
  required BuildContext context,
  required Widget body,
  bool barrierDismissible = true,
  Color barrierColor = const Color(0x80000000),
  double? width,
  // double elevation = 8.0,
  Duration transitionDuration = const Duration(milliseconds: 300),
  String? barrierLabel = "Side Sheet",
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  bool withCloseControll = true,
  bool ignoreAppBar = true,
  EdgeInsetsGeometry? margin,
}) {
  var of = MediaQuery.of(context);
  var platform = Theme.of(context).platform;
  if (width == null) {
    if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
      width = of.size.width * 0.6;
    } else {
      // width = of.size.width / 2;
      width = MediaQuery.of(context).size.width;
    }
  }
  double exceptionalheight = !ignoreAppBar
      ? Scaffold.of(context).hasAppBar
          ? Scaffold.of(context).appBarMaxHeight!
          : 0
      : 0;
  double height = of.size.height - exceptionalheight;
  assert(!barrierDismissible || barrierLabel != null);
  return showGeneralDialog(
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    context: context,
    pageBuilder: (BuildContext context, _, __) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Material(
          child: SizedBox(
            width: width,
            height: height,
            child: withCloseControll
                ? Stack(
                    children: [
                      body,
                      Positioned(
                        top: 5,
                        right: 5,
                        child: CloseButton(
                          color: AppTheme.white,
                        ),
                      )
                    ],
                  )
                : body,
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    },
  );
}
