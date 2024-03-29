//import 'page.dart';
import 'category.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/*

  TODO:
    app icon
    adding notes
    more elements
    multiple categories
    editing categories
    adaptive column count
    note coloring
    note reordering
    splash screen (android)
      https://medium.com/flutter-community/flutter-2019-real-splash-screens-tutorial-16078660c7a1
    server hosted notes

*/

/*
  MASON TIPS
    material you
    have link in settings to github
    and link to thulian yt
    
 */

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vNotes',

      //color theme configured here, reorganize colors when done with design
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const NewHomePage(),
      //home: const SplashPage(),
    );
  }
}

//mostly complete, need to figure out how to make it
//show up only at the start when launching
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  //splash page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: "vNotes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                ),
              ),
            ),
            const Text(
              "App made by",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Text(
              "Andrew Schmidt",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    var url = Uri.parse('https://www.google.com');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                text: 'Donations Appreciated',
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  NewHomePageState createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Category();
  }
}
