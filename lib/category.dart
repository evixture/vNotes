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

class Category extends StatelessWidget {
  List<Note> noteList = [];
  String catName = '';

  Category({super.key}) {
    readJSON('data/notes.json');
  }

  Future<void> readJSON(String path) async {
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
    //print(noteList);
  }

  @override
  Widget build(BuildContext context) {
    //Widget get() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: noteList.length,
      reverse: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        //doesnt get called
        print('itembuilder note at $index');
        return noteList[index];
      },
    );
  }
}
