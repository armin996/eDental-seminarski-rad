import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';

class UneditableProfilePhoto extends StatelessWidget {
  UneditableProfilePhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: authProvider.isAuthenticated &&
                        authProvider.user!.image != null &&
                        authProvider.user!.image!.isNotEmpty
                    ? Image.memory(authProvider.user!.image!).image
                    : const AssetImage('images/dummy.png'),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.bottomCenter,
          child: Text(
            authProvider.isAuthenticated
                ? authProvider.user!.username
                : 'username',
            style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
