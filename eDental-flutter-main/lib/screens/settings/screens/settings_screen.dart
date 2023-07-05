import 'dart:typed_data';

import 'package:edental/providers/authService.dart';
import 'package:edental/screens/settings/screens/arrangements_tile.dart';
import 'package:edental/screens/settings/screens/notification_tile.dart';
import 'package:edental/screens/settings/screens/profile_tile.dart';
import 'package:edental/screens/settings/screens/help_tile.dart';
import 'package:edental/screens/settings/screens/about_tile.dart';
import 'package:edental/screens/settings/screens/notification_tile.dart';
import 'package:edental/screens/settings/widgets/uneditable_photo.dart';
import 'package:flutter/material.dart';
import 'package:edental/screens/settings/models/settings.dart';
import 'package:edental/screens/settings/widgets/uneditable_photo.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:edental/models/user.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';
import '../../auth/auth_screen.dart';
import '../widgets/editable_photo.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  setImageFunction() {}
  @override
  Widget build(BuildContext context) {
    Uint8List? _image = null;
    void setImageFunction(Uint8List image) {
      _image = image;
    }

    final authProvider = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UneditableProfilePhoto(),
          SettingsTile(
              title: 'Profile',
              icon: Icons.person,
              destination: ProfileTile(user: authProvider.user)),
          SettingsTile(
              title: 'Notifications',
              icon: Icons.notifications,
              destination: NotificationTile(
                  authProvider.isAuthenticated ? authProvider.user! : null)),
          SettingsTile(
            title: 'Help',
            icon: Icons.book,
            destination: HelpTile(),
          ),
          SettingsTile(
              title: 'About us', icon: Icons.book, destination: AboutTile()),
          SettingsTile(
            title: 'Log out',
            icon: Icons.logout,
            destination: AuthScreen(),
            navigateToNewPage: false,
            functionToExecute: () => authProvider.logout(),
          ),
        ],
      ),
    );
  }
}
