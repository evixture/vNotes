import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';
import 'dart:io';
//import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

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
  List<NoteCoreData> ncdList = [];
  String catName = '';

  bool textChanged = false;
  bool submittedText = false;
  bool clickedOff = false;

  void permissionTest() async {
    //await Permission.storage.request();
  }

  void writeToFile(String data) async {
    var p = await getApplicationDocumentsDirectory();
    var f = File('${p.path}/notes.yaml');
    f.writeAsStringSync(data);
    print('wrote to yaml file on system at ${p.path}');
  }

  Future<void> readYAML(String path) async {
    // if (await Permission.storage.status.isGranted) {
    //   print("have storage permission");
    // }

    // if (await Permission.storage.request().isGranted) {
    //   var directory = await getExternalStorageDirectory();
    //   print(directory);
    // }

    //try to make a file locally
    // print('before writing new file');
    // var p = await getApplicationDocumentsDirectory();
    // var f = File('${p.path}/something.txt');
    // f.writeAsString("-> i hope this does something at least");
    // print('after writing new file');

    //var resp = await rootBundle.loadString(path);
    var p = await getApplicationDocumentsDirectory();
    var f = File('${p.path}/notes.yaml');
    YamlMap yaml = loadYaml(f.readAsStringSync());
    print("reading yaml file in ${p.path}");

    catName = yaml['name'];
    var yamlNoteList = yaml['notes'];
    //print(yamlNoteList);

    for (final noteData in yamlNoteList) {
      ncdList.add(NoteCoreData(noteData));
    }

    //update with new info from file
    setState(() {});
  }

  dynamic toYaml() {
    // String ret = "---\nname: $catName\nnotes:";
    // for (final n in ncdList) {
    //   ret += n.toYaml();
    // }
    // return ret;
    return {
      'name': catName,
      'notes': [
        for (final n in ncdList) ...{n.toYaml()}
      ]
    };
  }

  @override
  void initState() {
    super.initState();
    readYAML('data/notes.yaml');
  }

  //NOTE: dart:io does not work on web
  void writeToYaml(String path) {
    print("before writing to yaml");
    YamlWriter yw = YamlWriter();
    String yd = yw.write(toYaml());
    print("after writing to yaml");

    try {
      writeToFile(yd);
    } catch (e) {
      print("file error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: ncdList.length,
        reverse: true,
        padding: EdgeInsets.zero,
        //padding: const EdgeInsets.all(5),

        itemBuilder: (context, index) {
          return ListedNote(ncdList[index]);
        },
      ),
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
          height: 80,
          elevation: 0,
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: EditableText(
                  controller: TextEditingController(text: catName),
                  onSubmitted: (value) {
                    //print("submitted, $value");
                    catName = value;
                    textChanged = false;
                    //print("saved to file");
                    writeToYaml('data/notes.yaml');
                    //yamlUpdate();
                  },
                  // onEditingComplete: () {
                  //   print("editing complete");
                  // },
                  onChanged: (value) {
                    //print('changed text, $value');
                    catName = value;
                    textChanged = true;
                  },
                  onTapOutside: (event) {
                    //print("clicked off, $event");

                    if (textChanged) {
                      textChanged = false;
                      //print("saved to file");
                      writeToYaml('data/notes.yaml');
                      //yamlUpdate();
                    }
                  },
                  focusNode: FocusNode(
                    canRequestFocus: true,
                  ),
                  backgroundCursorColor: Colors.grey,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  permissionTest();
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
