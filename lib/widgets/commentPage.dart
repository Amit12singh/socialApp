// import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// void showCommentModal(BuildContext context) {
//   showMaterialModalBottomSheet(
//     context: context,
//     builder: (context) => CommentModal(),
//   );
// }

// class CommentModal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: ModalScrollController.of(context),
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Comments',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             _buildComment('User 1', 'This is an awesome comment!'),
//             _buildComment('User 2', 'Great job on this app!'),
//             _buildComment('User 3', 'I love the design.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildComment(String user, String comment) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             user,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(comment),
//         ],
//       ),
//     );
//   }
// }
