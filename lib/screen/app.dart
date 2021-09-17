import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'branchSelection.dart';
import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Grinta Coffee",
      home: SplashScreenView(
        navigateRoute: BranchSelection(),
        duration: 3000,
        imageSize: 200,
        imageSrc: "assets/images/logo.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}
