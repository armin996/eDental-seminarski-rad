// import 'dart:html';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';

class EditableProfilePhoto extends StatefulWidget {
  EditableProfilePhoto(
    this._image,
    this._setImageFunction, {
    Key? key,
  }) : super(key: key);
  final Uint8List? _image;
  final Function _setImageFunction;
  @override
  State<EditableProfilePhoto> createState() => _EditableProfilePhotoState();
}

class _EditableProfilePhotoState extends State<EditableProfilePhoto> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Image? shownImage;
  @override
  void initState() {
    if (widget._image != null) {
      shownImage = Image.memory(widget._image!);
    }
    // TODO: implement initState
    super.initState();
  }

  Future getImage() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      _image = result;
      widget._setImageFunction();
    }
  }

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
                backgroundImage: shownImage != null
                    ? shownImage?.image
                    : const AssetImage('images/dummy.png'),
              ),
              Positioned(
                bottom: 20.0,
                right: 25.0,
                child: InkWell(
                  onTap: (() {
                    getImage();
                  }),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.greenAccent,
                    size: 28.0,
                  ),
                ),
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
