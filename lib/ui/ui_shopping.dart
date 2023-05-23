import 'package:flutter/material.dart';



Widget createCloseButton(BuildContext context) => ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFFffcdb2)),
    ),
    child: Text("close"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );