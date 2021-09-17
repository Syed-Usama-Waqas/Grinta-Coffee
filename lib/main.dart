import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grinta/screen/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< Updated upstream
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text("Error"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const App();
        }
        return const App();
      },
    );
=======
  const MyApp({Key? key}) : super(key: key);

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return const App();
>>>>>>> Stashed changes
  }
}
