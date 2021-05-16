import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/aboutus_screen.dart';
import 'package:notes_app/screens/imp_notes_screen.dart';
import 'package:notes_app/screens/see_listview_screen.dart';
import 'package:notes_app/screens/showpassword_dilog.dart';
import './screens/tabs_screen.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notes(id TEXT, title TEXT, description TEXT, isImp INTEGER)",
      );
    },
    version: 1,
  );
  runApp(MyApp(database));
}

class MyApp extends StatefulWidget {
  final Future<Database> database;

  MyApp(this.database);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Notes> notes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              headline2: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headline3: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
              headline4: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
              headline5: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
      ),
      home: TabScreen(notes, widget.database),
      routes: {
        ImpNotes.routes: (_) => ImpNotes(notes, widget.database),
        AboutUs.route: (_) => AboutUs(notes),
        SeeNotes.route: (_) => SeeNotes(notes, widget.database),
        ShowDialogScreen.route: (_) => ShowDialogScreen(),
      },
    );
  }
}
