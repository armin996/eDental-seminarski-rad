import 'dart:convert';
import 'dart:typed_data';

import 'package:edental/models/dentist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DentistItem extends StatelessWidget {
  final Dentist dentist;
  const DentistItem(this.dentist, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          child: Image.memory(dentist.image),
        ),
        ListTile(
          title: Text(dentist.fullName),
          subtitle: Text(dentist.description),
        )
      ],
    ));
  }
}
