import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

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

  void readYAML(String path) {
    File f = File(path);
  }

  @override
  void initState() {
    super.initState();
    //readJSON calls set state when finished
    readJSON('data/notes.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: noteList.length,
        reverse: true,
        padding: EdgeInsets.zero,
        //padding: const EdgeInsets.all(5),

        itemBuilder: (context, index) {
          return noteList[index];
        },
      ),
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
          height: 80,
          elevation: 0,
          color: Colors.black,
          child: Row(
            children: [
              Text(
                //figure out how to grab from category
                catName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ],
          )),
    );
  }
}

/* 

MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: noteList.length,
      reverse: true,
      padding: EdgeInsets.zero,
      //padding: const EdgeInsets.all(5),

      itemBuilder: (context, index) {
        return noteList[index];
      },
    );


Scaffold(
      backgroundColor: Colors.black,
      body: cat,
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
          height: 80,
          elevation: 0,
          color: Colors.black,
          child: Row(
            children: [
              const Text(
                //figure out how to grab from category
                "TEMP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ],
          )),
    );


*/