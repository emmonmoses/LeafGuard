import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final EdgeInsetsGeometry tilePadding;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 18),
  }) : super(key: key);

  @override
  CustomExpansionTileState createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: widget.tilePadding,
            child: Row(
              children: [
                Expanded(child: widget.title),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AppTheme.white,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...widget.children,
      ],
    );
  }
}
