import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:notes_app/screens/aboutus_screen.dart';
import 'package:notes_app/screens/imp_notes_screen.dart';
import 'package:notes_app/screens/see_listview_screen.dart';
import 'package:notes_app/screens/showpassword_dilog.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class NavigationDrawer extends StatelessWidget {
  final List<Notes> notes;

  NavigationDrawer(this.notes);

  Widget buildSideDrawerItems(
      String title, IconData icon, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.yellow[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Notes App!',
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[900],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              splashColor: Colors.red,
              hoverColor: Colors.purple,
              child: buildSideDrawerItems('Add Note', Icons.note_add, context),
              onTap: () {
                //
                bool isNewRouteSameAsCurrent = false;

                Navigator.popUntil(context, (route) {
                  if (route.settings.name == TabScreen.routeName) {
                    isNewRouteSameAsCurrent = true;
                    Navigator.pop(context);
                  }
                  return true;
                });

                if (!isNewRouteSameAsCurrent) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            ),
            InkWell(
              splashColor: Colors.red,
              hoverColor: Colors.purple,
              child:
                  buildSideDrawerItems('Notes', Icons.note_outlined, context),
              onTap: () {
                bool isNewRouteSameAsCurrent = false;

                Navigator.popUntil(context, (route) {
                  if (route.settings.name == SeeNotes.route) {
                    isNewRouteSameAsCurrent = true;
                    Navigator.pop(context);
                  }
                  return true;
                });

                if (!isNewRouteSameAsCurrent) {
                  Navigator.popAndPushNamed(context, SeeNotes.route);
                }
              },
            ),
            InkWell(
              splashColor: Colors.red,
              hoverColor: Colors.purple,
              child: buildSideDrawerItems('IMP Notes', Icons.security, context),
              onTap: () {
                bool isNewRouteSameAsCurrent = false;

                Navigator.popUntil(context, (route) {
                  if (route.settings.name == ShowDialogScreen.route) {
                    isNewRouteSameAsCurrent = true;
                    Navigator.pop(context);
                  }
                  return true;
                });

                if (!isNewRouteSameAsCurrent) {
                  Navigator.popAndPushNamed(context, ShowDialogScreen.route);
                }
              },
            ),
            InkWell(
              hoverColor: Colors.purple,
              splashColor: Colors.red,
              child: buildSideDrawerItems(
                  'About us', Icons.account_box_outlined, context),
              onTap: () {
                // No Same Page Pushed Agin and Again

                bool isNewRouteSameAsCurrent = false;

                Navigator.popUntil(context, (route) {
                  if (route.settings.name == AboutUs.route) {
                    isNewRouteSameAsCurrent = true;
                    Navigator.pop(context);
                  }
                  return true;
                });

                if (!isNewRouteSameAsCurrent) {
                  Navigator.popAndPushNamed(context, AboutUs.route);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
