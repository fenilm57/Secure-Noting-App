import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/single_note.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleList extends StatefulWidget {
  final int index;
  final List<Notes> notes;
  final Future<Database> database;

  SingleList(this.notes, this.index, this.database);

  @override
  _SingleListState createState() => _SingleListState();
}

class _SingleListState extends State<SingleList> {
  final snackBar = SnackBar(content: Text('Deleted!'));

  Future<void> deleteNote(String id) async {
    // Get a reference to the database.
    final db = await widget.database;
    await db.delete(
      'notes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      child: Card(
        elevation: 10,
        // color: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) =>
                    SingleNote(widget.notes, widget.index, widget.database),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[900],
                child: Text(
                  '${widget.index + 1}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              title: Text(
                '${widget.notes[widget.index].title}',
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  print('Delete');
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        'Delete!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      content: Text(
                        'Are you Sure?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await deleteNote(
                              widget.notes[widget.index].id,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.popAndPushNamed(
                                context, TabScreen.routeName);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  );

                  // Navigator.popAndPushNamed(context, TabScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
