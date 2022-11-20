import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/auth.dart';
import 'package:flutter_application_1/pages/loading_screen.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const LoadingScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}