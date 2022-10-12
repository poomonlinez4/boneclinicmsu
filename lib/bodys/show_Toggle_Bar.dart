// import 'package:flutter/material.dart';
// import 'package:toggle_bar/toggle_bar.dart';

// class ShowToggleBar extends StatefulWidget {
//   const ShowToggleBar({Key? key}) : super(key: key);

//   @override
//   State<ShowToggleBar> createState() => _ShowToggleBarState();
// }

// class _ShowToggleBarState extends State<ShowToggleBar> {
//   List<String> labels = ['Home', 'Message', 'Notification', 'Setting'];
//   int counter = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrange,
//       appBar: AppBar(
//         title: Text('Toggle Bar'),
//         centerTitle: true,
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             ToggleBar(
//               labels: labels,
//               textColor: Colors.white,
//               selectedTextColor: Colors.black,
//               backgroundColor: Colors.lightBlue,
//               selectedTabColor: Colors.lightBlueAccent,
//               labelTextStyle: TextStyle(fontWeight: FontWeight.bold),
//               onSelectionUpdated: (index) {
//                 setState(() {
//                   counter = index;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 200,
//             ),
//             Text(
//               labels[counter],
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 50,
//                   color: Colors.black),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
