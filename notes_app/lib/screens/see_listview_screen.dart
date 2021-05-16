import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/drawer.dart';
import 'package:notes_app/widget/single_list.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class SeeNotes extends StatefulWidget {
  static const route = '/see-notes';
  final List<Notes> notes;

  final Future<Database> database;
  SeeNotes(this.notes, this.database);

  @override
  _SeeNotesState createState() => _SeeNotesState();
}

class _SeeNotesState extends State<SeeNotes> {
  List<Notes> saveNotes = [];
  List<Notes> save;

  @override
  void initState() {
    super.initState();
    displayNotes();
    // saveNotes = widget.notes.where((element) => element.isImp == 0).toList();
  }

  void displayNotes() async {
    save = await notes();
    setState(() {
      saveNotes = save.where((element) => element.isImp == 0).toList();
    });
    print('savenote :${saveNotes.length}');
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Notes>> notes() async {
    final Database db = await widget.database;

    final List<Map<String, dynamic>> maps = await db.query('notes');
    print('In Notes Method');

    return List.generate(maps.length, (i) {
      return Notes(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isImp: maps[i]['isImp'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      drawer: NavigationDrawer(widget.notes),
      body: Container(
        color: Colors.blue[200],
        child: ListView.builder(
          itemCount: saveNotes.length,
          itemBuilder: (context, index) {
            return SingleList(saveNotes, index, widget.database);
          },
        ),
      ),
    );
  }
}
