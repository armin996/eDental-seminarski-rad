import 'package:edental/main.dart';
import 'package:edental/providers/authService.dart';
import 'package:edental/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../providers/auth.dart';

class NotificationTile extends StatefulWidget {
  NotificationTile(this.user, {super.key});

  User? user;
  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _pushNotificationsEnabled = false;
  bool _newsletterEnabled = false;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    if (widget.user != null) {
      _pushNotificationsEnabled = widget.user!.isNotificationEnabled;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    final userProvider = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text('Push notifications', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 8.0),
            SwitchListTile(
              title: Text(_pushNotificationsEnabled ? 'Enabled' : 'Disabled'),
              value: _pushNotificationsEnabled,
              onChanged: (value) async {
                setState(() {
                  _pushNotificationsEnabled = value;
                });
                if (authProvider.isAuthenticated) {
                  User? user = authProvider.user;
                  user!.isNotificationEnabled = _pushNotificationsEnabled;
                  final result = await userProvider.update(user!.id ?? 0, user);
                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Succesfully updated notification status")));
                  }
                }
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Subscribe to our newsletter',
                style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            SwitchListTile(
              title: Text('On'),
              value: _newsletterEnabled,
              onChanged: (value) {
                setState(() {
                  _newsletterEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Theme', style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            SwitchListTile(
              title: const Text('Dark mode'),
              value: _darkThemeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkThemeEnabled = value;
                });
                if (_darkThemeEnabled) {
                  MaterialApp(
                    theme: ThemeData.dark(),
                    home: TabScreen(),
                  );
                } else {
                  MaterialApp(
                    theme: ThemeData.light(),
                    home: TabScreen(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
