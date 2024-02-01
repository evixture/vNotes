import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',

      //color theme configured here, reorganize colors when done with design
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const NewHomePage(),
      //home: const SplashPage(),

      //home: const HomePage(title: 'Flutter Demo Home Page'),
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
        itemCount: 20,
        reverse: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var rng = Random();
          return testNote(true, 'something', rng.nextDouble() * 300 + 150);
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

class oldListView extends StatelessWidget {
  const oldListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: [
        Row(
          children: [
            /*
              PROBLEM
                left and right column should have different heights but are the same,
                having the same bounds is ok if they both align to the bottom, but
                the smaller one aligns centered :(
            */

            //left column
            Expanded(
                child: Column(
              verticalDirection: VerticalDirection.up,
              children: [
                testNote(true, "test1", 100),
                testNote(false, "test3", 150),
                testNote(false, "test4", 150)
              ],
            )),
            //right column
            Expanded(
                child: Column(
              verticalDirection: VerticalDirection.up,
              children: [testNote(true, "test2", 200)],
            )),
          ],
        )
      ],
    );
  }
}

/*
const Text(
                "CATEGORY NAME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),



  //right column
              Expanded(
                  child: Column(
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [testNote("test2")],
              )),
*/

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

Row titleNoteElement(String text) {
  return Row(
    children: [
      Expanded(
          //fit: FlexFit.loose,
          child: RichText(
              text: TextSpan(
                  text: text,
                  style: const TextStyle(
                    //color: Colors.black,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))))
    ],
  );
}

Row textNoteElement(String text) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(right: 5),
        child: const Icon(Icons.short_text_rounded, color: Colors.white),
      ),
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
        titleNoteElement('Title Note Element'),
        textNoteElement(text),
        textNoteElement(text),
      ],
    ),
  );
}

/*
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      );
    }

  //note
  Container(
    //outside
    margin: EdgeInsets.all(15),
    //inside
    padding: EdgeInsets.all(15),
    height: 400,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 0, color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: [
        //note elements
        Row(
          children: [
            Icon(Icons.text_fields_rounded),
            RichText(
                text: TextSpan(
                    text: "NOTE TEXT",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ],
    ),
  ),

*/

//---------------
//
//  OLD STUFF
//
//---------------

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
