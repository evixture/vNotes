import 'noteElement.dart';
import 'navButton.dart';
import 'package:flutter/material.dart';

//idea - class that stores main data for note so
//switching between list notes and focused notes,
//as well as saving data to yaml is easier
class NoteCoreData {
  dynamic yamlInput = '';

  List<BasicElement> eList = [];
  String lastEdit = '';
  bool edited = false;
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

  NoteCoreData.withoutYaml() {
    lastEdit = DateTime.now().toString();

    eList.add(
      TextElement("This is a brand new note! Maybe this will work first time!"),
    );
  }

  dynamic toYaml() {
    bool tempEdited = edited;
    if (edited) edited = false;

    return {
      'lastEdit': tempEdited ? DateTime.now().toString() : lastEdit,
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
                    padding: const EdgeInsets.all(10.0),
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

//https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget-in-flutter
// ignore: must_be_immutable
class FocusedNote extends StatefulWidget {
  NoteCoreData ncd;

  FocusedNote(this.ncd, {super.key});

  @override
  State<FocusedNote> createState() => _FocusedNoteState();
}

class _FocusedNoteState extends State<FocusedNote> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //reverse: true,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TimeStampElement(widget.ncd.lastEdit),
            ),
            for (final el in widget.ncd.eList) ...{
              Padding(
                padding: const EdgeInsets.all(5.0),
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
                //temp
                //Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.black,
                  shape: Border.all(style: BorderStyle.none),
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddElementButton(
                          Icons.abc,
                          "Title",
                          () {
                            widget.ncd.eList.add(TitleElement("New Title!"));
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        AddElementButton(
                          Icons.abc,
                          "Text",
                          () {
                            widget.ncd.eList.add(TextElement("New Text"));
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
