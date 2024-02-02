import 'package:flutter/material.dart';

class BasicElement
{
  const BasicElement();

  Container get()
  {
    return Container();
  }
}

/*
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

*/

class TitleElement extends BasicElement
{
  String text = '';

  TitleElement(this.text);//takes in json??

  @override
  Container get()
  {
    return Container(
      child: Row(
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
              )
            )
          )
        )
      ],
    ),
  );  }
}