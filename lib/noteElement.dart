import 'package:flutter/material.dart';

class BasicElement extends StatelessWidget {
  const BasicElement({super.key});

  Widget get() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
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

class TitleElement extends BasicElement {
  String text = '';

  TitleElement(this.text, {super.key}); //takes in json??

  @override
  Widget build(BuildContext context) {
//  Widget get() {
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
}
