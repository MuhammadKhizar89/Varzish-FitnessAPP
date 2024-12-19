import 'package:flutter/material.dart';
import 'package:varzish/screens/onboarding/onboarding.dart';
import 'package:varzish/utils/screenConstraints.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Varzish",
      theme: ThemeData(
        fontFamily: 'Poppins', // Default font family
      ),
      home: Scaffold(
        body: MyWidget(),
      ),
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: ScreenSize.height(context),
          width: ScreenSize.height(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/_backgroundImage.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Onboarding(),
      ],
    );
  }
}
// Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         colors: [Colors.black, Colors.green],
        //         stops: [0.20, 1]),
        //   ),
        // ),
        // Container(
        //   decoration: const BoxDecoration(
        //     gradient: RadialGradient(
        //       center: Alignment.center,
        //       radius: 0.5,
        //       colors: [Colors.transparent, Colors.black45],
        //     ),
        //   ),
        // ),