import 'package:flutter/material.dart';
import 'package:varzish/screens/onboarding/onboarding.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 255, 13));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
      ),
      title: "Varzish",
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Colors.green],
                    stops: [0.20, 1]),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.5,
                  colors: [Colors.transparent, Colors.black45],
                ),
              ),
            ),
            Onboarding(),
          ],
        ),
      ),
    ),
  );
}
