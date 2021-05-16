import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/drawer.dart';
import 'package:notes_app/screens/showpassword_dilog.dart';
import 'package:sqflite/sqflite.dart';
import './addnote_Screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/';
  final List<Notes> notes;

  final Future<Database> database;
  final bool showToast;

  TabScreen(this.notes, this.database, {this.showToast});
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int tabIndex = 0;
  String title;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      {
        'page': AddNotesScreen(widget.notes, widget.database),
        'title': 'Add Note'
      },
      {
        'page': ShowDialogScreen(
          tabFunction: indexChange,
        ),
        'title': 'Important Notes'
      },
    ];
  }

  void indexChange(int index) {
    setState(() {
      tabIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text(
          _pages[tabIndex]['title'],
        ),
      ),
      drawer: NavigationDrawer(widget.notes),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.pink,
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
          print(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Add Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.security,
            ),
            label: 'IMP Note',
          ),
        ],
      ),
      body: _pages[tabIndex]['page'],
      backgroundColor: Colors.lightBlue[200],
    );
  }
}
