import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'note.dart';

/*
  MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: 15,
        reverse: true,
        padding: EdgeInsets.zero,
        //addAutomaticKeepAlives: false,
        //clipBehavior: Clip.antiAlias,
        //addRepaintBoundaries: false,
        itemBuilder: (context, index) {
          //item builder is called whenever an item is on screen
          //this is likely what is causing the inconsistent ordering
          //because random is being called every time an item
          //re-enters the screen
          var rng = Random();
          double rngHeight = rng.nextDouble() * 300 + 150;
          //return testNote(true, '$index, ${rngHeight.round()}', rngHeight);
          return Note('Note Title Text', rngHeight).get();
        },
      ),

 */

class Category extends StatefulWidget {
  //constant variables if any

  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  //variables that change on update
  List<Note> noteList = [];
  String catName = '';

  Future<void> readJSON(String path) async {
    print("-> called readJSON");
    var resp = await rootBundle.loadString('data/notes.json');
    Map<String, dynamic> data = await json.decode(resp);

    catName = data['name'];
    //need to add [0] to the end for some reason, should figure
    //out why its like this later
    var jsonNoteList = data['notes'][0];

    for (final noteData in jsonNoteList) {
      //print("noteData in category : $noteData");
      noteList.add(Note(noteData));
    }
    print('-> noteList from JSON: $noteList');

    setState(() {
      print('-> setState from JSON');
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    print("-> called initState");

    super.initState();
    setState(() {
      print("-> called setState");
      readJSON('data/notes.json');
    });
  }

  @override
  Widget build(BuildContext context) {
    print("-> called category Build");
    print("-> $noteList");
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: noteList.length,
      reverse: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        //gets called before readjson finishes and doesnt get called again
        print('-> itembuilder note at $index');
        print('-> note ${noteList[index]}');
        return noteList[index];
      },
    );
  }
}
