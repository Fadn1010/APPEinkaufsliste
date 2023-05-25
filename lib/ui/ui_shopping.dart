import 'package:flutter/material.dart';

PreferredSize designApp(){
  return PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Shopping List',
            style: TextStyle(
                color: Color(0xFF2f2d7d),
                fontSize: 50,
                fontFamily: "Beauty Brand"),
          ),
          backgroundColor: const Color(0xFFffcdb2),
          elevation: 0,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      );
}

Widget createCloseButton(BuildContext context) => ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFFffcdb2)),
    ),
    child: const Text("close"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );