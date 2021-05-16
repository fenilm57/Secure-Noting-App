import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/drawer.dart';
import 'package:notes_app/screens/tabs_screen.dart';
import 'package:sqflite/sqflite.dart';

class SingleNote extends StatefulWidget {
  final List<Notes> notes;
  final int index;
  final Future<Database> database;

  SingleNote(this.notes, this.index, this.database);

  @override
  _SingleNoteState createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText;
  final snackBar = SnackBar(content: Text('Updated!'));

  @override
  void initState() {
    super.initState();
    initialText = widget.notes[widget.index].description;
    _editingController = TextEditingController(
      text: initialText,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editingController.dispose();
  }

  Future<void> updateNotes(Notes notes) async {
    final db = await widget.database;

    await db.update(
      'notes',
      notes.toMap(),
      where: "id = ?",
      whereArgs: [notes.id],
    );
  }

  Widget _editTitleTextField() {
    if (_isEditingText) {
      return Center(
        child: TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          maxLines: null,
          autofocus: true,
          controller: _editingController,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Card(
        elevation: 10,
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.all(25),
          child: Text(
            initialText,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.notes[widget.index].title}'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[300],
      drawer: NavigationDrawer(widget.notes),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 400,
                width: 400,
                // color: Colors.blue,
                margin: EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _editTitleTextField(),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  print('Clicked');
                  setState(() {
                    initialText = _editingController.text;

                    _isEditingText = false;
                  });
                  print(initialText);
                  await updateNotes(Notes(
                    id: widget.notes[widget.index].id,
                    title: widget.notes[widget.index].title,
                    description: initialText,
                    isImp: widget.notes[widget.index].isImp,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.popAndPushNamed(context, TabScreen.routeName);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue[900],
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
