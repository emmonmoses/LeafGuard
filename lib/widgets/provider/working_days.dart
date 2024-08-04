import 'package:flutter/material.dart';

class WorkingDaysTile extends StatelessWidget {
  final Widget? dayWidget;
  final Widget? hourWidget;

  const WorkingDaysTile({
    Key? key,
    this.dayWidget,
    this.hourWidget,
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
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: dayWidget,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: hourWidget,
                ),
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
