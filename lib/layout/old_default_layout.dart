// import 'package:flutter/material.dart';
//
// class DefaultLayout extends StatelessWidget {
//   DefaultLayout({Key? key, required this.child, this.appbar}) : super(key: key);
//   final Widget child;
//   Future<AppBar?>? appbar;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: appbar,
//       builder: (context, snapshot) => Scaffold(
//         appBar: snapshot.data,
//         body: Padding(
//           padding: const EdgeInsets.only(top: 30),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
