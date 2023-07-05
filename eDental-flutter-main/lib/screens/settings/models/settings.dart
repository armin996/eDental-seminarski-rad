import 'dart:async';

import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget destination;
  final FutureOr<Function?> functionToExecute;

  var navigateToNewPage;
  SettingsTile(
      {required this.title,
      required this.icon,
      required this.destination,
      this.navigateToNewPage = true,
      this.functionToExecute});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () async {
        if (functionToExecute != null) {
          await functionToExecute!!();
        }
        if (navigateToNewPage != null && navigateToNewPage) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destination,
            ),
          );
        }
      },
    );
  }
}
