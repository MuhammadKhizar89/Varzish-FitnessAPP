// // //IMPLICT
// // import 'package:flutter/material.dart';
// // import 'dart:math'; // Required for mathematical constants like pi

// // class TestAnimation extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Simple Transform Rotation"),
// //       ),
// //       body: Center(
// //         child: TweenAnimationBuilder<double>(
// //           tween: Tween<double>(begin: 0, end: 90),
// //           duration: Duration(seconds: 2),
// //           builder: (BuildContext context, double value, Widget? child) {
// //             return Transform.rotate(
// //               angle: value * pi / 180, // Convert 45 degrees to radians
// //               child: Container(
// //                 height: 100,
// //                 width: 100,
// //                 color: Colors.blue,
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //EXPLICIT
// import 'package:flutter/material.dart';
// import 'dart:math'; // Required for mathematical constants like pi

// class TestAnimation extends StatefulWidget {
//   @override
//   _TestAnimationState createState() => _TestAnimationState();
// }

// class _TestAnimationState extends State<TestAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the AnimationController
//     _controller = AnimationController(
//       vsync: this, // TickerProvider
//       duration: Duration(seconds: 2), // Animation duration
//     );

//     // Define the rotation animation (from 0 to 90 degrees)
//     _rotationAnimation = Tween<double>(begin: 0, end: 90).animate(_controller);

//     // Start the animation
//     _controller.repeat();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller to free resources
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Explicit Animation"),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _rotationAnimation,
//           builder: (context, child) {
//             return Transform.rotate(
//               angle: _rotationAnimation.value *
//                   pi /
//                   180, // Convert degrees to radians
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 color: Colors.blue,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
