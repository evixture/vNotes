// ignore: file_names
import 'package:flutter/material.dart';

abstract class BasicElement extends StatelessWidget {
  const BasicElement({super.key});

  dynamic toYaml();

  Widget getListed(BuildContext context);
  Widget getFocused(BuildContext context);
}

// ignore: must_be_immutable
class TitleElement extends BasicElement {
  String text = '';

  TitleElement(this.text, {super.key});

  @override
  dynamic toYaml() {
    return {'type': 'title', 'data': text};
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(color: Colors.red);
  }

  @override
  Widget getListed(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
              //color: Colors.black,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )));
  }

  @override
  Widget getFocused(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
              //color: Colors.black,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            )));
  }
}

// ignore: must_be_immutable
class TextElement extends BasicElement {
  String text = '';

  TextElement(this.text, {super.key});

  @override
  dynamic toYaml() {
    return {'type': 'text', 'data': text};
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(color: Colors.red);
  }

  @override
  Widget getListed(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
              //color: Colors.black,
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            )));
  }

  @override
  Widget getFocused(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
              //color: Colors.black,
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: 20,
            )));
  }
}
