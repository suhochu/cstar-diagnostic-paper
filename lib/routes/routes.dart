// import 'package:cstarimage_testpage/screen/result_page.dart' deferred as result_page;
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../model/lecture_code.dart';
// import '../screen/code_insert/code_insert_page.dart';
// import '../screen/questions/new_question_sheet_page.dart' deferred as question_page;
// import '../screen/selections/diaganosis_selection_page.dart' deferred as selection_page;
//
// class RouteConfig {
//   static GoRouter goRouter = GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(
//         path: '/',
//         name: '/',
//         builder: (_, __) => CodeInsertPage(),
//       ),
//       GoRoute(
//         path: '/diagnosisSelectionPage',
//         name: 'diagnosisSelectionPage',
//         builder: (_, __) => DeferredRoute(
//           selection_page.loadLibrary,
//           () => selection_page.DiagnosisSelectionPage(),
//         ),
//         routes: [
//           GoRoute(
//             path: 'NewQuestionsSheet',
//             name: 'NewQuestionsSheet',
//             builder: (_, GoRouterState state) {
//               if (state.extra is Test) {
//                 return DeferredRoute(
//                   question_page.loadLibrary,
//                   () => question_page.NewQuestionSheet(
//                     // qAndAData: state.extra as QAndAData?,
//                     test: state.extra as Test,
//                   ),
//                 );
//               } else {
//                 return DeferredRoute(
//                   selection_page.loadLibrary,
//                   () => selection_page.DiagnosisSelectionPage(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       GoRoute(
//         path: '/ResultPage',
//         name: 'ResultPage',
//         builder: (_, state) => DeferredRoute(
//           result_page.loadLibrary,
//           () => result_page.ResultPage(),
//         ),
//       ),
//     ],
//   );
// }
//
// class DeferredRoute extends StatelessWidget {
//   const DeferredRoute(this.future, this.buildChild, {super.key});
//
//   final Future<dynamic> Function() future;
//   final Widget Function() buildChild;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<dynamic>(
//         future: future(),
//         builder: ((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return buildChild();
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }));
//   }
// }
