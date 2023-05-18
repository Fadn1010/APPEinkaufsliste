// import 'package:flutter/material.dart';
// import '../model/einkaufen.dart';
//
//
//
// class Hinzufuegen extends StatefulWidget {
//
//   final ArtikelListe artikeln;
//   Hinzufuegen({required this.artikeln});
//
//   @override
//   State<Hinzufuegen> createState() => _HinzufuegenState();
// }
//
// class _HinzufuegenState extends State<Hinzufuegen> {
//   late ArtikelListe artikeln;
//
//   @override
//   void initState() {
//     super.initState();
//     artikeln = widget.artikeln;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: TextField(
//         onChanged: (value) {
//           setState(() {
//             artikeln.name = value;
//           });
//         },
//         decoration: InputDecoration(
//           labelText: 'Einkaufsliste Name',
//         ),
//       ),
//       trailing: Container(
//         width: 100,
//         child: TextField(
//           style: TextStyle(fontSize: 20),
//           textAlign: TextAlign.center,
//           onChanged: (value) {
//             setState(() {
//               artikeln.menge = int.parse(value);
//             });
//           },
//           decoration: InputDecoration(
//             labelStyle: TextStyle(fontSize: 15),
//             labelText: 'Menge',
//           ),
//         ),
//       ),
//     );
//   }
// }
