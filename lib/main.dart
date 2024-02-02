import 'noteElement.dart';
import 'note.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'package:yaml/yaml.dart';

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
  const SplashPage({Key? key}) : super(key: key);

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
                  ))),
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
                )),
          )
        ],
      )),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: 15,
        reverse: true,
        padding: EdgeInsets.zero,
        //addAutomaticKeepAlives: false,
        //clipBehavior: Clip.antiAlias,
        //addRepaintBoundaries: false,
        itemBuilder: (context, index) {
          //item builder is called whenever an item is on screen
          //this is likely what is causing the inconsistent ordering
          //because random is being called every time an item
          //re-enters the screen
          var rng = Random();
          double rngHeight = rng.nextDouble() * 300 + 150;
          //return testNote(true, '$index, ${rngHeight.round()}', rngHeight);
          return Note('Note Title Text', rngHeight).get();
        },
      ),
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
          height: 80,
          elevation: 0,
          color: Colors.black,
          child: Row(
            children: [
              const Text(
                "CATEGORY NAME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ],
          )),
    );
  }
}

Row testNoteElement(bool drawIcon, String text) {
  return Row(
    children: [
      if (drawIcon) ...{
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(Icons.text_fields_rounded, color: Colors.white),
        ),
      },
      RichText(
          text: TextSpan(
              text: text,
              style: const TextStyle(
                  //color: Colors.black,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)))
    ],
  );
}




Container testNote(bool drawIcon, String text, double noteHeight) {
  return //note
      Container(
    //outside
    margin: const EdgeInsets.all(5),
    //inside
    padding: const EdgeInsets.all(5),
    height: noteHeight,
    //width: 150,
    //trying to align notes in row to bottom, not working well so far
    //alignment: Alignment.topRight,

    /*
      SOLID WHITE BG
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      */
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(width: 2, color: Colors.white),
      //border: Border.all(width: 2, color: Color(Random().nextInt(0xffffffff))),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: [
        //note elements
        TitleElement('Title Text').get(),
        textNoteElement(text),
        textNoteElement(text),
      ],
    ),
  );
}
