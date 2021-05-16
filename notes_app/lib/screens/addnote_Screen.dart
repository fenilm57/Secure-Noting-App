import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:sqflite/sqflite.dart';

class AddNotesScreen extends StatefulWidget {
  final List<Notes> notes;
  final Future<Database> database;
  AddNotesScreen(this.notes, this.database);

  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController desciptionController = TextEditingController();

  int isImp = 0;
  bool switchCase = false;

  bool validateTextFields = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addNotes(String title, String description, int isImp) async {
    final addnote = Notes(
      title: title,
      description: description,
      isImp: isImp,
      id: DateTime.now().toString(),
    );
    await insertNotes(addnote);
    // widget.notes.add(addnote);
    print('object123s');
    // List<Notes> save = await notes();
  }

//Insert Note
  Future<void> insertNotes(Notes notes) async {
    final Database db = await widget.database;

    await db.insert(
      'notes',
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
//

  Widget buildTextFieldWidget(
      String title, int lines, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(),
      margin: EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: title,
          // errorText: validateTextFields ? 'Cannot be Empty' : null,
        ),
        controller: controller,

        // autofocus: true,
        maxLines: lines,
        validator: (value) {
          return (value == '') ? 'Please Enter Detail' : null;
        },
        // textAlign: TextAlign.center,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //Add Notes
    addNotes(titleController.text, desciptionController.text, isImp);

    print(titleController.text);
    print(desciptionController.text);
    print(isImp);
    // Clears Title and desciption
    titleController.clear();
    desciptionController.clear();
    setState(() {
      switchCase = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Image(
            image: AssetImage('images/notes.png'),
            width: 200,
            height: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextFieldWidget('Enter Title', 1, titleController),
                  buildTextFieldWidget(
                      'Enter Description', 8, desciptionController),
                ],
              )),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'IMP Notes',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Switch(
                  activeColor: Colors.yellow,
                  value: switchCase,
                  onChanged: (value) {
                    setState(() {
                      switchCase = value;
                      if (value == false) {
                        isImp = 0;
                      } else {
                        isImp = 1;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            height: 60,
            child: ElevatedButton.icon(
              onPressed: () {
                //Validate
                _submit();
              },
              label: Text(
                'Add',
                style: Theme.of(context).textTheme.headline2,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              icon: Icon(Icons.note_add_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
