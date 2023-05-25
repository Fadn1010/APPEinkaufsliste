import 'package:flutter/material.dart';

class AppDesign extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(double.infinity, 80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Shopping List',
        style: TextStyle(
          color: Color(0xFF2f2d7d),
          fontSize: 50,
          fontFamily: "Beauty Brand",
        ),
      ),
      backgroundColor: const Color(0xFFffcdb2),
      elevation: 0,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }

}


// class CloseButton extends StatelessWidget {
//   final BuildContext context;
//   const CloseButton({required this.context,Key? key, }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(const Color(0xFFffcdb2)),
//       ),
//       child: const Text("close"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//   }
// }

Widget createCloseButton(BuildContext context) => ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFFffcdb2)),
    ),
    child: const Text("close"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );