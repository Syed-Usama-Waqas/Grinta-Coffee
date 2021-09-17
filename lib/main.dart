import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grinta/screen/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Container(
              child: Center(
                child: Text("Error"),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        }
        return App();
      },
    );
  }
}
