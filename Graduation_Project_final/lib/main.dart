import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_final/login.dart';
import 'package:graduation_project_final/register.dart';
import 'package:graduation_project_final/results.dart';
import 'package:graduation_project_final/upload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCZOUTFZqZunvZYZBgAf3Ofgq5nxX-G5Ec",
        appId: "73230298504:android:615382febcca0799985e3d",
        messagingSenderId: "73230298504",
        projectId: "alzheimer-detection-ef445"),
  );
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Courgette",
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.deepPurple[600],
          )),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/upload': (context) => Upload(),
        '/result': (context) => const Result(),
      },
    );
  }
}
