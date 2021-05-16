import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/drawer.dart';

class AboutUs extends StatelessWidget {
  static const route = '/about-us';

  final List<Notes> notes;
  AboutUs(this.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      drawer: NavigationDrawer(notes),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Fenil Mehta',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
