import 'dart:typed_data';

import 'package:edental/providers/authService.dart';
import 'package:edental/screens/settings/widgets/editable_photo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edental/screens/settings/widgets/profile_textfield.dart';
import 'package:provider/provider.dart';

import '../../../enums/gender.dart';
import '../../../enums/role.dart';
import '../../../models/user.dart';
import '../../../providers/auth.dart';

class ProfileTile extends StatefulWidget {
  ProfileTile({this.user, super.key});
  User? user;
  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _addressController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneController;
  String _firstName = '';
  String _username = '';
  String _password = '';
  String _city = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  late Gender _gender;
  late Role _role;
  Uint8List? _image = null;
  User? user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    if (user != null) {
      _firstNameController = TextEditingController(text: user!.firstName);
      _lastNameController = TextEditingController(text: user!.lastName);
      _usernameController = TextEditingController(text: user!.username);
      _passwordController = TextEditingController();
      _cityController = TextEditingController();
      _phoneController = TextEditingController(text: user!.phone);
      _emailController = TextEditingController(text: user!.email);
      _addressController = TextEditingController(text: user!.address);
      _role = user!.role!;
      _gender = user!.gender!;
      // setState(() {
      //   _firstNameController.text = _firstName;
      //   _lastNameController.text = _lastName;
      //   _usernameController.text = _username;
      //   _passwordController.text = _password;
      //   _cityController.text = _city;
      //   _emailController.text = _email;
      //   _addressController.text = _address;
      //   _phoneController.text = _phone;
      // });
    } else {
      _firstNameController = TextEditingController();
      _lastNameController = TextEditingController();
      _usernameController = TextEditingController();
      _passwordController = TextEditingController();
      _cityController = TextEditingController();
      _phoneController = TextEditingController();
      _emailController = TextEditingController();
      _addressController = TextEditingController();
      _gender = Gender.values[0];
      _role = Role.values[1];
    }
    // _firstName = '';
    // _lastName = '';
    // _username = '';
    // _password = '';
    // _city = '';
    // _phone = '';
    // _address = '';
    // _email = '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      _firstName = _firstNameController.text;
      _lastName = _lastNameController.text;
      _username = _usernameController.text;
      _address = _addressController.text;
      _email = _emailController.text;
      _phone = _phoneController.text;
      _password = _passwordController.text;
      _city = _cityController.text;
    });
  }

  void _discardChanges() {
    setState(() {
      _firstNameController.text = _firstName;
      _lastNameController.text = _lastName;
      _usernameController.text = _username;
      _passwordController.text = _password;
      _cityController.text = _city;
      _emailController.text = _email;
      _addressController.text = _address;
      _phoneController.text = _phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    void setImageFunction(Uint8List image) {
      setState(() {
        _image = image;
      });
    }

    final auth = Provider.of<Auth>(context);
    final userProvider = Provider.of<UserService>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60.0, 0, 60.0, 0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus;
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                EditableProfilePhoto(
                    (auth.isAuthenticated &&
                            auth.user!.image != null &&
                            auth.user!.image!.isNotEmpty
                        ? auth.user!.image!
                        : null) as Uint8List?,
                    setImageFunction),
                ProfileTextfield(
                    label: 'First name',
                    placeholder: 'Enter your first name',
                    isPasswordTextfield: false,
                    controller: _firstNameController),
                ProfileTextfield(
                    label: 'Last name',
                    placeholder: 'Enter your last name',
                    isPasswordTextfield: false,
                    controller: _lastNameController),
                ProfileTextfield(
                  label: 'Username',
                  placeholder: 'Username',
                  isPasswordTextfield: false,
                  controller: _usernameController,
                ),
                ProfileTextfield(
                  label: 'Password',
                  placeholder: 'Your pasword',
                  isPasswordTextfield: true,
                  controller: _passwordController,
                ),
                ProfileTextfield(
                  label: 'City',
                  placeholder: 'City that you live in',
                  isPasswordTextfield: false,
                  controller: _cityController,
                ),
                ProfileTextfield(
                  label: 'Email',
                  placeholder: 'Enter your email address',
                  isPasswordTextfield: false,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Gender'),
                SwitchListTile(
                    title: Text(_gender == Gender.Male ? 'Male' : 'Female'),
                    value: _gender == Gender.Male,
                    onChanged: (val) => setState(() {
                          _gender = val ? Gender.Male : Gender.Female;
                        })),
                const Text('Role'),
                SwitchListTile(
                  title: Text(_role == Role.Admin ? 'Admin' : 'User'),
                  value: _role == Role.Admin,
                  onChanged: null,
                ),
                ProfileTextfield(
                  label: 'Address',
                  placeholder: 'Address where you live in',
                  isPasswordTextfield: false,
                  controller: _addressController,
                ),
                ProfileTextfield(
                    label: 'Phone',
                    placeholder: 'Your phone number',
                    isPasswordTextfield: false,
                    controller: _phoneController),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Dispose'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          User userToRegisterOrUpdate = User(
                              address: _addressController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              phone: _phoneController.text,
                              email: _emailController.text,
                              role: _role,
                              gender: _gender,
                              image: _image,
                              password: _passwordController.text,
                              passwordConfirm: _passwordController.text,
                              username: _usernameController.text);
                          if (auth.isAuthenticated) {
                            userToRegisterOrUpdate.id = auth.user!.id ?? 0;
                            final result = userProvider.update(
                                userToRegisterOrUpdate.id ?? 0,
                                userToRegisterOrUpdate);
                            if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Successufully updated')));
                            }
                          } else {
                            auth.signUp(userToRegisterOrUpdate);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Accept'),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
