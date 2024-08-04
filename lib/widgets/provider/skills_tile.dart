import 'package:flutter/material.dart';

class SkillsTile extends StatelessWidget {
  final Widget? label;

  const SkillsTile({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label!,
                // Text(
                //   '$hour'.toUpperCase(),
                // ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
