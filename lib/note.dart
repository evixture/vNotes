import 'noteElement.dart';
import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  List<BasicElement> eList = [];
  String debugText = '';
  double noteHeight = 0;

  Note(dynamic jsonNote, {super.key}) {
    for (final element in jsonNote) {
      //print('-> $element');

      //eventually make into a switch
      if (element['type'] == 'title') {
        eList.add(TitleElement(element['data']));
      }
      if (element['type'] == 'text') {
        eList.add(TextElement(element['data']));
      }
    }
  }

  jsonNote(dynamic jsonNote) {
    noteHeight = 150;
  }

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
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: () {
              print("note tapped");
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  //note elements
                  for (final element in eList) ...{element}
                ],
              ),
            ),
          ),
        ),
      ),
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
