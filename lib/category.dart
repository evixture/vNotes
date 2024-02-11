import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';
import 'dart:io';
//import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

//NOTE: dart:io does not work on web
void writeToYaml(String path, String data) {
  //print("before writing to yaml");
  YamlWriter yw = YamlWriter();
  String yd = yw.write(data);
  //print("after writing to yaml");

  try {
    writeToNoteFile(yd);
  } catch (e) {
    //print("file error: ${e.toString()}");
  }
}

void writeToNoteFile(String data) async {
  if (Platform.isAndroid || Platform.isIOS) {
    var p = await getApplicationDocumentsDirectory();
    File f = File('${p.path}/notes.yaml');
    f.writeAsStringSync(data);
  } else {
    File f = File('data/notes.yaml');
    f.writeAsStringSync(data);
  }
}

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

  Future<void> readYAML(String path) async {
    String resp;

    if (Platform.isAndroid || Platform.isIOS) {
      var p = await getApplicationDocumentsDirectory();
      File f = File('${p.path}/notes.yaml');
      resp = f.readAsStringSync();
    } else {
      resp = await rootBundle.loadString(path);
    }

    YamlMap yaml = loadYaml(resp);
    //print("reading yaml file in ${p.path}");

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
                    catName = value;
                    textChanged = false;

                    writeToYaml('data/notes.yaml', toYaml());
                  },
                  // onEditingComplete: () {
                  //   print("editing complete");
                  // },
                  onChanged: (value) {
                    catName = value;
                    textChanged = true;
                  },
                  onTapOutside: (event) {
                    if (textChanged) {
                      textChanged = false;
                      writeToYaml('data/notes.yaml', toYaml());
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
                  //do stuff
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
