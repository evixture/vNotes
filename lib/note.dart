import 'noteElement.dart';
import 'package:flutter/material.dart';

//eventually remove once json works
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

class Note
{
  List<BasicElement> eList = [];
  String debugText = '';
  double noteHeight;

  Note(this.debugText, this.noteHeight)
  {
    eList.add(TitleElement("Title from Note"));
    eList.add(TitleElement("Title from Note"));
  }

  Container get()
  {
    return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(5),
    height: noteHeight,
    
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
        for (final element in eList) ...{ element.get() }
      ],
    ),
  );
  }
}

/*  
        TitleElement('Title Text').get(),
        textNoteElement(debugText),
        textNoteElement(debugText),
*/