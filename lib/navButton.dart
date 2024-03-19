import 'package:flutter/material.dart';

class AddElementButton extends StatefulWidget {
  const AddElementButton(this.icon, this.name, this.onClick, {super.key});

  final Function onClick;
  final IconData icon;
  final String name;

  @override
  State<AddElementButton> createState() => _AddElementButtonState();
}

class _AddElementButtonState extends State<AddElementButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      //color: Colors.red,
      child: Material(
        color: Colors.white,
        child: InkWell(
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.black),
              const SizedBox(
                width: 5,
              ),
              RichText(
                text: TextSpan(
                  text: widget.name,
                  style: const TextStyle(
                    //color: Colors.black,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            widget.onClick.call();
          },
        ),
      ),
    );
  }
}
