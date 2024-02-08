// ignore: file_names
import 'package:flutter/material.dart';

abstract class BasicElement extends StatelessWidget {
  const BasicElement({super.key});

  String toYaml();

  @override
  Widget build(BuildContext context);
}

// ignore: must_be_immutable
class TitleElement extends BasicElement {
  String text = '';

  TitleElement(this.text, {super.key});

  @override
  String toYaml() {
    return "- type: title\ndata: $text";
  }

  @override
  Widget build(BuildContext context) {
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
                      ))))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TextElement extends BasicElement {
  String text = '';

  TextElement(this.text, {super.key});

  @override
  String toYaml() {
    return "- type: text\ndata: $text";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
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
                        //fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ))))
        ],
      ),
    );
  }
}
