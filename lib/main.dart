import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

      //home: const NewHomePage(),
      home: const SplashPage(),

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
}

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
