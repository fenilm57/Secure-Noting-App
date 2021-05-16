import 'package:flutter/material.dart';

import 'imp_notes_screen.dart';

class ShowDialogScreen extends StatefulWidget {
  static const route = '/show-dialog';
  final Function tabFunction;
  ShowDialogScreen({this.tabFunction});

  @override
  _ShowDialogScreenState createState() => _ShowDialogScreenState();
}

class _ShowDialogScreenState extends State<ShowDialogScreen> {
  final TextEditingController passwordController = TextEditingController();

  final String password = '1472';

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Text('Enter Password'),
        content: Container(
          height: 100,
          width: 300,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    errorText: _validate ? 'Incorrect Password' : null,
                  ),
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 250,
            child: ElevatedButton(
              child: Text(
                'Enter',
                style: TextStyle(letterSpacing: 2.0, fontSize: 18),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              onPressed: () {
                if (passwordController.text.isEmpty ||
                    passwordController.text != password) {
                  setState(() {
                    _validate = true;
                  });
                } else {
                  Navigator.popAndPushNamed(context, ImpNotes.routes);
                }

                // Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
    );
  }
}
