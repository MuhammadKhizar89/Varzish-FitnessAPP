import 'package:flutter/material.dart';
import 'package:varzish/utils/app_constants.dart';

class BackgroundTheme extends StatelessWidget {
  const BackgroundTheme({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
