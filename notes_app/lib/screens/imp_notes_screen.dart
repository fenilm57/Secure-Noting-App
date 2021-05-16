import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/widget/single_list.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class ImpNotes extends StatefulWidget {
  static const routes = '/impNotes';
  final List<Notes> notes;
  final Future<Database> database;

  ImpNotes(this.notes, this.database);

  @override
  _ImpNotesState createState() => _ImpNotesState();
}

class _ImpNotesState extends State<ImpNotes> {
  List<Notes> saveNotes = [];
  List<Notes> save;

  @override
  void initState() {
    super.initState();
    displayNotes();
    // saveNotes = widget.notes.where((element) => element.isImp == 1).toList();
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Notes>> notes() async {
    final Database db = await widget.database;

    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Notes(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isImp: maps[i]['isImp'],
      );
    });
  }

  void displayNotes() async {
    List<Notes> save = await notes();
    setState(() {
      saveNotes = save.where((element) => element.isImp == 1).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Important Notes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Container(
        color: Colors.blue[200],
        child: ListView.builder(
          itemCount: saveNotes.length,
          itemBuilder: (context, index) {
            return SingleList(
              saveNotes,
              index,
              widget.database,
            );
          },
        ),
      ),
    );
  }
}
