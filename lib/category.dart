import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaml/yaml.dart';

import 'note.dart';

class Category extends StatefulWidget {
  //constant variables if any

  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  //variables that change on update, info is persistent
  //when set state is called, this class is redrawn
  List<Note> noteList = [];
  String catName = '';

  Future<void> readJSON(String path) async {
    var resp = await rootBundle.loadString('data/notes.json');
    Map<String, dynamic> data = await json.decode(resp);

    catName = data['name'];

    //list of notes
    var jsonNoteList = data['notes'];
    //print('-> jsonNote: $jsonNoteList');

    for (final noteData in jsonNoteList) {
      //print('-> adding note with $noteData');
      noteList.add(Note(noteData));
    }

    //update with new info from file
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //readJSON calls set state when finished
    readJSON('data/notes.json');
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: noteList.length,
      reverse: true,
      padding: EdgeInsets.zero,
      //padding: const EdgeInsets.all(5),

      itemBuilder: (context, index) {
        return noteList[index];
      },
    );
  }
}
