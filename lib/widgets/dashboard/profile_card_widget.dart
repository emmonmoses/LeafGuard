// Project Imports
import 'package:leafguard/themes/app_theme.dart';

// Flutter Imports
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  "assets/user.jpg",
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Emmon Moses",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text("Admin"),
                ],
              )
            ],
          ),
          Divider(
            thickness: AppTheme.dividerThickness,
            color: AppTheme.main,
          ),
          profileListTile("Joined Date", "18-Apr-2021"),
          profileListTile("Services", "32 Active"),
          profileListTile("Earnings", "\$.125,300"),
          appversionTile(
            'Copyright',
            Icons.copyright_sharp,
            '${DateTime.now().year}',
          )
        ],
      ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.defaultTextColor,
            ),
          ),
        ],
      ),
    );
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
}
