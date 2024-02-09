import 'noteElement.dart';
import 'package:flutter/material.dart';

//idea - class that stores main data for note so
//switching between list notes and focused notes,
//as well as saving data to yaml is easier
class NoteCoreData {
  dynamic yamlInput = '';

  List<BasicElement> eList = [];
  String lastEdit = '';
  //other vars like color and timestamp once added

  NoteCoreData(this.yamlInput) {
    //https://api.flutter.dev/flutter/dart-core/DateTime-class.html
    //lastEdit = DateTime.parse(yamlInput['lastEdit']);
    //can parse lastEdit string with DateTime to do time stuff
    lastEdit = yamlInput['lastEdit'];

    for (final element in yamlInput['elements']) {
      //eventually make into a switch
      if (element['type'] == 'title') {
        eList.add(TitleElement(element['data']));
      }
      if (element['type'] == 'text') {
        eList.add(TextElement(element['data']));
      }
    }
  }

  dynamic toYaml() {
    // String ret = "- lastEdit: ${DateTime.now()}\nelements:";
    // for (final el in eList) {
    //   ret += el.toYaml();
    // }
    return {
      'lastEdit': DateTime.now().toString(),
      'elements': [
        for (final el in eList) ...{el.toYaml()}
      ]
    };
  }
}

// ignore: must_be_immutable
class ListedNote extends StatelessWidget {
  NoteCoreData ncd;

  ListedNote(this.ncd, {super.key});

  @override
  Widget build(BuildContext context) {
    //things tried so far
    //material->ink->column

    return Container(
      margin: const EdgeInsets.all(5),
      child: Material(
        color: Colors.black,
        child: Ink(
          //margin: const EdgeInsets.all(5),
          //padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            //color: Colors.black,
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: () {
              //print("note tapped");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FocusedNote(ncd),
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //note elements
                for (final element in ncd.eList) ...{
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: element.getListed(context),
                  )
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FocusedNote extends StatefulWidget {
  NoteCoreData ncd;

  FocusedNote(this.ncd, {super.key});

  @override
  State<FocusedNote> createState() => _FocusedNoteState();
}

class _FocusedNoteState extends State<FocusedNote> {
  //NoteCoreData ncd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            for (final el in widget.ncd.eList) ...{
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: el.getFocused(context),
              )
            }
          ],
        ),
      ),
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
          height: 80,
          elevation: 0,
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: EditableText(
                  controller: TextEditingController(text: "something"),
                  focusNode: FocusNode(
                    canRequestFocus: true,
                  ),
                  backgroundCursorColor: Colors.grey,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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

/*

return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap:() {
          print("note tapped");
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          //doesnt resize to fit contents
          //height: 300,

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
              for (final element in eList) ...{element}
            ],
          ),
        ),
      ),
    );

 */
