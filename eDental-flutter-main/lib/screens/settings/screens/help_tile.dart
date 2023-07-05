import 'package:flutter/material.dart';

class HelpTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Help',
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Need help? Check out our frequently asked questions and troubleshooting tips below:',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('How do I reset my password?'),
            subtitle: Text(
                'To reset your password, go to the login screen and click on the "forgot password" link. You will receive an email with instructions on how to reset your password.'),
          ),
          Divider(),
          ListTile(
            title: Text('How do I update my account information?'),
            subtitle: Text(
                'To update your account information, go to the profile section and click on the "edit profile" button. From there, you can update your name, email address, and other information.'),
          ),
          Divider(),
          ListTile(
            title: Text('How do I contact customer support?'),
            subtitle: Text(
                'You can contact customer support by sending an email to support@eDental.com. We will respond to your inquiry as soon as possible.'),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'If you have any other questions or concerns, please don\'t hesitate to contact us!',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
