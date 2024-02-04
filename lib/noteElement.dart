// ignore: file_names
import 'package:flutter/material.dart';

class BasicElement extends StatelessWidget {
  const BasicElement({super.key});

  @override
  Container build(BuildContext context) {
    return Container();
  }
}

class TitleElement extends BasicElement {
  String text = '';

  TitleElement(this.text, {super.key});

  @override
  Container build(BuildContext context) {
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
